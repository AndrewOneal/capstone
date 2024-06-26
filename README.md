# SpoilerGuard App

A mobile application that allows users to find information about movies and TV shows without being spoiled.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Flutter SDK (<https://flutter.dev/docs/get-started/install>)

### Environment Variables

|       Variable       | Required |              Default               |                              Description                               |
| :------------------: | :------: | :--------------------------------: | :--------------------------------------------------------------------: |
|   `DB_IP`    |    ✓     |          'http://127.0.0.1:8090'          |                 IP of the database for the app to connect with               |

### Installing

Install the dependencies and convert .env.example to .env

```sh-session
flutter pub get
```

### Pocketbase

This project uses [Pocketbase](https://pocketbase.io/docs/) as the backend. To host a local instance of the database run the following commands

```sh-session
./database/pocketbase serve
```

#### Android

Connect your device to your computer and run the following commands

```sh-session
flutter build apk
flutter install
```

#### Windows

```sh-session
flutter build windows
flutter install
```

## Running the tests

```sh-session
flutter test
```

## Authors

- **Andrew Oneal** - [LinkedIn](https://www.linkedin.com/in/andrewjoneal)
- **Munene Gatobu** - [LinkedIn](https://www.linkedin.com/in/munenegatobu)
- **Spencer Yates** - [LinkedIn](https://www.linkedin.com/in/sdy329)

See also the list of [contributors](https://github.com/AndrewOneal/capstone/contributors) who participated in this project.

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
