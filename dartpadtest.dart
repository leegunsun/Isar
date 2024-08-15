

void main() {
  Map<String, int> ages = {
    'Alice': 30,
    'Bob': 25,
  };

Map<int, MapEntry> test = ages.entries.toList().asMap();

ages.update("Bob", (value) => 2);

print(ages);
print(test);

}