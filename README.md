# Building Management System

A simple web application for managing buildings using Ruby on Rails. This application allows users to create, read, update, and delete building records, as well as upload and parse CSV files containing building data.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)

## Features

- Create, Read, Update, and Delete (CRUD) operations for building records.
- Upload and parse CSV files to add multiple buildings at once.
- Search and sort buildings by name or height.
- Export building data to CSV format.

## Technologies Used

- Ruby on Rails
- SQLite (for development)
- RSpec (for testing)

## Installation


   ```bash
   git clone https://github.com/yourusername/building_management_system.git
   cd building_management_system

   bundle install

   rails db:create
   rails db:migrate

   rails db:seed

   rails server
```
