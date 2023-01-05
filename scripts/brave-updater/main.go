package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"io"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

const fileTemplate = `
# Auto generated
final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "{{.Version}}";

    src = prev.fetchurl {
      url = "{{.URL}}";
      sha256 = "{{.SHA256}}";
    };
  });
}
`

type Release struct {
	TagName string  `json:"tag_name"`
	Name    string  `json:"name"`
	Assets  []Asset `json:"assets"`
}

type Asset struct {
	Name string `json:"name"`
	URL  string `json:"browser_download_url"`
}

func main() {
	wd, _ := os.Getwd()
	fmt.Printf("Current Directory: %s\n", wd)

	release, err := getLatestStableRelease()
	if err != nil {
		panic(err)
	}
	asset, err := getAsset(release)
	if err != nil {
		panic(err)
	}

	hash, err := getHash(asset.URL)
	if err != nil {
		panic(err)
	}
	if err := createFile(wd, release, asset, hash); err != nil {
		panic(err)
	}
	fmt.Println("Done")
}

func getLatestStableRelease() (*Release, error) {
	res, err := http.Get("https://api.github.com/repos/brave/brave-browser/releases")
	if err != nil {
		panic(err)
	}
	defer res.Body.Close()

	b, err := io.ReadAll(res.Body)
	if err != nil {
		panic(err)
	}

	var releases []*Release
	if err := json.Unmarshal(b, &releases); err != nil {
		panic(err)
	}

	for _, release := range releases {
		if strings.HasPrefix(release.Name, "Release") {
			fmt.Printf("Latest version: %s\n", release.TagName)
			return release, nil
		}
	}

	return nil, fmt.Errorf("Failed to get latest stable release")
}

func getAsset(release *Release) (*Asset, error) {
	for _, asset := range release.Assets {
		if !strings.HasSuffix(asset.Name, "_amd64.deb") {
			continue
		}
		return &asset, nil
	}
	return nil, fmt.Errorf("Failed to get asset")
}

func getHash(url string) (string, error) {
	cmd := exec.Command("nix-prefetch-url", url)
	out, err := cmd.Output()
	if err != nil {
		return "", err
	}
	hash := strings.Trim(string(out), "\n")
	fmt.Printf("SHA256: %s\n", hash)

	return hash, nil
}

func createFile(wd string, release *Release, asset *Asset, hash string) error {
	tmpl, err := template.New("file").Parse(fileTemplate)
	if err != nil {
		return err
	}

	f, err := os.Create(filepath.Join(wd, "overlays", "brave.nix"))
	if err != nil {
		return err
	}
	defer f.Close()

	if err := tmpl.Execute(f, map[string]string{
		"Version": strings.TrimPrefix(release.TagName, "v"),
		"URL":     asset.URL,
		"SHA256":  hash,
	}); err != nil {
		return err
	}
	return nil
}
