import 'package:meta/meta.dart';

class Registry<T> {
  final _registry = <Type, Record<T>>{};

  void  registry<S extends T>(Record<S> record) => _registry.addAll({S: record});

  T resolve<S extends T>() => _registry[S]?.instance;

  void clear() => _registry.clear();

  List<T> get items => _registry.values.map((r) => r.instance).toList();
}

class Record<T> {
  final T Function() builder;
  T _instance;

  T get instance {
    _instance ??= builder();
    return _instance;
  }

  Record({@required this.builder});
}