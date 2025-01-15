# SoundPlugs

**SoundPlugs** is a platform for purchasing audio plugins, including effects, treatments, and synthesizers, designed for use in Digital Audio Workstations (DAWs). Built with Symfony, it provides a simple and secure marketplace where users can browse and purchase plugins. The platform also includes an admin panel built with EasyAdmin for managing the platform's content.

## Key Features

- **Plugin Marketplace**: Users can browse a variety of audio plugins available for purchase.
- **User Registration/Login**: Secure authentication system to manage purchases and personal details.
- **Search & Filters**: Search for plugins by category, type, or name to find the perfect plugin.
- **Admin Panel**: An admin panel built with EasyAdmin for managing users, plugins, and orders.

## Prerequisites

Before you begin, ensure you have the following installed:

- [PHP]
- [Composer]
- [MySQL] (or another relational SQL database)
- [(SymfonyCLI)]

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/r0-ch/soundplugs.git
   cd soundplugs
   ```

1. **Install dependencies**:

  ```bash
  composer install
  ```

3. **Configure environment**:
   
  Create a .env file at the root of the project and add your configuration, for example:
  
  ```
  DATABASE_URL=mysql://user:password@localhost:3306/soundplugs
  ```

4. **Configure environment**:

  Run the following commands to create the database and run migrations:

  ```bash
  php bin/console doctrine:database:create
  php bin/console doctrine:migrations:migrate
  php bin/console doctrine:fixtures:load
  ```

5. **Run the application**:

   ```bash
   symfony server:start
   ```

## Project Structure

- `src/` : Contains the main source code.
  - `Controller/` : Controllers for handling requests (e.g., plugin listings, user authentication).
  - `Entity/` : Doctrine entities representing users, plugins, and purchases.
  - `Repository/` : Repositories for querying data from the database.
  - `Service/` : Business logic for handling user actions, etc.
  - `Form/` : Forms for user registration and purchase processes.
  - `DataFixtures/` : Fixtures for populating the database with sample data (e.g., users, plugins).
  - `Security/` : Contains security-related configurations, including voters for authorization logic.

## Contributing


## Author


## License

