# Keep all classes in a package
-keep class com.example.myapp.** { *; }

# Keep a specific class
-keep class com.example.myapp.MyClass { *; }

# Keep all methods in a class
-keep class com.example.myapp.MyClass { *; }

# Keep a specific method
-keep class com.example.myapp.MyClass { void myMethod(); }

# Keep all classes in a package and its sub-packages
-keep class com.example.myapp.** { *; }

# Keep all classes in the current package
-keep class com.example.myapp.** { *; }

# Keep the CustomHeader class and its constructor
-keep class com.example.myapp.CustomHeader {
  public <init>(...);
}


# Keep FontAwesome classes and resources
-keep class com.example.myapp.font_awesome_flutter.** { *; }
-keepclassmembers class com.example.myapp.font_awesome_flutter.** { *; }
