# 📱 Pokédex Flutter

Uma Pokédex desenvolvida em Flutter utilizando a [PokeAPI](https://pokeapi.co/), com suporte a **cache offline via Hive**, **busca por nome**, **diferentes artes visuais** e **exibição de informações detalhadas** dos Pokémon.

## 📁 Arquitetura

Este projeto foi desenvolvido com foco em **Clean Code** e **Clean Architecture**, garantindo uma estrutura organizada, escalável e de fácil manutenção.

## ✨ Funcionalidades

- 🔄 **Scroll infinito**: os Pokémon são carregados dinamicamente conforme o usuário rola a lista.
- 💾 **Cache offline com Hive**: os dados baixados são salvos localmente, permitindo uso **offline** sem necessidade de conexão após o primeiro carregamento.
- 🎨 **Troca de artes**: possibilidade de alternar entre **3 estilos diferentes** de imagens dos Pokémon.
- 🔍 **Busca por nome**: sistema de pesquisa em tempo real para localizar rapidamente qualquer Pokémon.
- 📋 **Informações detalhadas**: ao pressionar um Pokémon, são exibidos dados como nome, tipo, altura e peso.

## 🧠 Objetivo do Projeto

O principal propósito desse app foi me aprofundar no consumo de **APIs REST**, aprender a implementar **cache local** usando o [Hive](https://pub.dev/packages/hive) e aplicar na prática os conceitos de **Clean Architecture** e **Clean Code**.

## 🛠️ Tecnologias e Pacotes

- **Flutter** + **Dart**
- [Hive](https://pub.dev/packages/hive) — armazenamento local
- [PokeAPI](https://pokeapi.co/) — dados dos Pokémon
- [`http`](https://pub.dev/packages/http) — requisições à API
- Gerenciamento de estado: Provider

## 🖼️ Prévia
[![Demonstração do Pokédex](https://img.youtube.com/vi/hvz_ZomjZp4/maxresdefault.jpg)](https://www.youtube.com/watch?v=hvz_ZomjZp4)

## 🔗 Link para download
[https://drive.google.com/file/d/1LaifKKq6VmDl1IKq_A-sBbW9aB_3_wXJ/view?usp=drive_link](https://drive.google.com/file/d/1LaifKKq6VmDl1IKq_A-sBbW9aB_3_wXJ/view?usp=drive_link)
