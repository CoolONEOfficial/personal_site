# Personal site

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[<img alt="Deployed with FTP Deploy Action" src="https://img.shields.io/badge/Deployed With-FTP DEPLOY ACTION-%3CCOLOR%3E?style=for-the-badge&color=0077b6">](https://github.com/SamKirkland/FTP-Deploy-Action)

Personal site portfolio written on Publish

### Features

* Fully static
* Dark/Light theme support
* SEO friendly (JSON-LD, Open graph etc)
* RSS integration

## 👶 Start

### Install dependencies

``` bash
$ yarn install
```

### Run static site

Generate & run static site.

```bash
$ publish run
```

## 🚀 Build and Deploy to FTP

### 🎉 Deploy

Create config on root "ftp.json"

```json
{
    "username": "name",
    "password": "pass",
    "host": "test.ru",
    "port": 21
}

```

```bash
$ publish deploy
```
