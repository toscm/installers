# Installers

Scripts to install my core utils on different operating systems

## Usage

```bash
tmp_dir=$(mktemp -d)
git clone --depth 1 https://github.com/toscm/installers.git "$tmp_dir"
bash "$tmp_dir/ubuntu22/coreutils"
bash "$tmp_dir/ubuntu22/R"
cp anyos/.Rprofile ~
cp anyos/.lintr ~ 
rm -rf $tmp_dir
```

## Scripts

Helper scripts for often recurring tasks are available in folder `sys`. As of April 2024 the following helpers are available:

- configure_git
- create_keypair
- create_user
