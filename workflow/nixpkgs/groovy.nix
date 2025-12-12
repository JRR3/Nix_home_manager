{ pkgs

,
}:

pkgs.groovy.override {
  javaHome = pkgs.openjdk17;
}

