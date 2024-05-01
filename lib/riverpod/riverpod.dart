import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polaris/module/form/repo/form_repo.dart';

final formProvider = ChangeNotifierProvider<FormRepo>((ref) => FormRepo());
