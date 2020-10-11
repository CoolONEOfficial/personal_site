# Personal site

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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
