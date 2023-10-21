import 'package:my_project/my_project.dart';

Future main() async {
  final app = Application<MyProjectChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;                  //puerto del localHost::8888

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
