<div align="center">

# asdf-aws-vault [![Build](https://github.com/asdf-community/asdf-aws-vault/actions/workflows/build.yml/badge.svg)](https://github.com/asdf-community/asdf-aws-vault/actions/workflows/build.yml) [![Lint](https://github.com/asdf-community/asdf-aws-vault/actions/workflows/lint.yml/badge.svg)](https://github.com/asdf-community/asdf-aws-vault/actions/workflows/lint.yml)

[aws-vault](https://github.com/ByteNess/aws-vault) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-aws-vault  ](#asdf-aws-vault--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

# Dependencies

- `bash`, `curl`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add aws-vault
# or
asdf plugin add aws-vault https://github.com/asdf-community/asdf-aws-vault.git
```

aws-vault:

```shell
# Show all installable versions
asdf list-all aws-vault

# Install specific version
asdf install aws-vault latest

# Set a version globally (on your ~/.tool-versions file)
asdf global aws-vault latest

# Now aws-vault commands are available
aws-vault --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/asdf-community/asdf-aws-vault/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [asdf-community](https://github.com/asdf-community/)

# Credits

- Original [asdf-aws-vault](https://github.com/karancode/asdf-aws-vault) plugin by karancode
- [asdf-kubectl](https://github.com/asdf-community/asdf-kubectl) plugin
- [asdf-plugin-template](https://github.com/asdf-vm/asdf-plugin-template)
