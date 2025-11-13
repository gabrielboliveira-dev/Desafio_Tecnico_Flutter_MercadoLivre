# 🛒 Desafio Técnico: Clone da Busca (Mercado Livre)

Este projeto é um **aplicativo Flutter** que simula a funcionalidade de **busca de produtos do Mercado Livre (MELI)**.  
O objetivo é consumir a **API pública do MELI**, exibir uma lista de resultados e permitir a navegação até uma **tela de detalhes do produto**.

O foco principal é demonstrar o uso de uma **arquitetura limpa e reativa**, com **gerenciamento de estado desacoplado** e **navegação estruturada entre telas**.

---

## 🚀 Funcionalidades

### 🔍 Tela de Busca
- Campo de texto (`TextField`) para digitar o termo de busca.  
- Ao submeter (pressionar "Enter" ou botão), o app consulta a API do MELI.  
- Exibe:
  - ⏳ Indicador de carregamento (loading) durante a busca.  
  - ⚠️ Mensagem de erro em caso de falha.  
- Lista os resultados em uma `ListView`, mostrando:
  - 🖼️ Imagem (thumbnail)  
  - 🏷️ Título  
  - 💰 Preço  

### 🧭 Navegação
- Ao clicar em um item da lista, o app navega para a **tela de detalhes**.  
- O **ID do produto** é passado como argumento entre as telas.  

### 🧾 Tela de Detalhes
- Busca os **detalhes completos** do item usando o ID.  
- Exibe:
  - 📸 Galeria de fotos (se disponível)  
  - 🏷️ Título  
  - 💰 Preço formatado  

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Descrição |
|-------------|------------|
| **Flutter (SDK)** | Framework principal para desenvolvimento multiplataforma |
| **Provider** | Gerenciamento de estado (busca e detalhes) |
| **http** | Comunicação com a API REST do Mercado Livre |
| **cached_network_image** | Cache e carregamento eficiente de imagens |
| **intl** | Formatação de moeda e internacionalização |

---

## 🎯 Objetivos de Aprendizado (Clean Architecture)

- **Estado de Busca (Search State):**  
  Gerenciar um estado reativo disparado por ação do usuário (e não no `initState`).

- **Múltiplos Providers (SRP):**  
  Separar responsabilidades:
  - `ProductSearchProvider` → resultados de busca  
  - `ProductDetailsProvider` → detalhes do produto  

- **Navegação com Argumentos:**  
  Passagem de parâmetros entre `SearchPage` e `DetailsPage`.

- **Análise de JSON (Parsing):**  
  Lidar com as estruturas de resposta da API MELI.

---

## 🌐 Endpoints da API (Mercado Livre Brasil - MLB)

| Método | Endpoint | Descrição |
|--------|-----------|-----------|
| `GET` | `https://api.mercadolibre.com/sites/MLB/search?q={query}` | Busca produtos pelo termo informado |
| `GET` | `https://api.mercadolibre.com/items/{item_id}` | Obtém detalhes de um produto específico |
