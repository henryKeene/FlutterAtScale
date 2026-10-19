enum AppEnvironment {
  development('Development'),
  staging('Staging'),
  production('Production');

  new(this.label);

  final String label;
}
