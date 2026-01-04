# CLAUDE.md

## Project Overview

NBA Ruby is a Ruby interface to the NBA Stats API. It provides an idiomatic
Ruby wrapper around NBA's statistical data endpoints.

## Development Commands

```bash
bundle exec rake test      # Run tests
bundle exec rake lint      # Run RuboCop linter
bundle exec rake mutant    # Run mutation testing (full suite)
bundle exec rake steep     # Run type checker
bundle exec rake yard      # Generate documentation
bundle exec rake           # Run all quality checks
```

### Running Mutant for Individual Classes

Always run mutant on individual classes during development rather than the full suite:

```bash
bundle exec mutant run --include lib --require nba --use minitest 'NBA::ClassName'
bundle exec mutant run --include lib --require nba --use minitest 'NBA::ClassName#method_name'
```

Only run the full mutant suite (`bundle exec rake mutant`) at the end, after all individual classes pass.

## Reference Libraries

This library should maintain:
- **Feature parity** with [nba_api](https://github.com/swar/nba_api) (Python)
- **Style consistency** with [mlb-ruby](https://github.com/sferik/mlb-ruby)

## Code Style and Conventions

### Fixing RuboCop Offenses

When asked to fix RuboCop offenses, **actually refactor the code to fix them.**
Never disable offenses, either inline with `# rubocop:disable` comments or in
`.rubocop.yml`. The goal is clean, idiomatic Ruby code that passes all linting
rules.

### Internal Consistency is Critical

Before implementing any new feature, analyze existing similar features in the
codebase and follow the same patterns exactly. Look at:
- How similar API endpoints are implemented
- How data models are structured
- How tests are organized
- How documentation is written

### Parameter Naming

**Never use parameters ending in `_id` in public methods.** Instead:

```ruby
# WRONG
def self.find(player_id:, client: CLIENT)
  path = "endpoint?PlayerID=#{player_id}"
  ...
end

# CORRECT
def self.find(player:, client: CLIENT)
  id = Utils.extract_id(player)
  path = "endpoint?PlayerID=#{id}"
  ...
end
```

Parameters should accept either:
- An ID (String or Integer)
- An object with an `id` method (e.g., `NBA::Player`, `NBA::Team`)

Use `Utils.extract_id(entity)` to normalize the value.

### Predicate Methods

Convert boolean-like API responses to Ruby predicate methods:

```ruby
# API returns "is_active" or boolean flags
def active?
  is_active
end

# API returns "Y"/"N" strings
def greatest_75?
  greatest_75_flag.eql?("Y")
end

# API returns numeric flags (1/0)
def win?
  wl.eql?("W")
end

def loss?
  wl.eql?("L")
end

# Shot made (1) or missed (0)
def made?
  shot_made_flag.eql?(1)
end
```

For enums with few options (win/loss, made/missed), provide predicate methods for each state.

### Value Equality with `.eql?`

**Always use `.eql?` instead of `==`** when comparing values where both would produce the same result:

```ruby
# WRONG - mutation testing will catch this
def win?
  wl == "W"
end

# CORRECT - survives mutation testing
def win?
  wl.eql?("W")
end
```

This is required for mutation testing to verify the comparison is actually tested.

### Type Annotations

**Keep all type annotations in `sig/nba.rbs`.** Never add inline type annotations
(like `#: -> String` or `# @type var`) in Ruby source files. Steep reads type
signatures from the RBS file, keeping the Ruby code clean and the types
centralized in one place.

## Mutation Testing Requirements

**All new code must have 100% mutation coverage.** This requires specific testing patterns:

### Testing Hash Key Access

When accessing data from a hash, write tests for both:
1. When the key is present (returns the value)
2. When the key is missing (returns nil or raises, depending on `fetch` vs `[]`)

```ruby
# In the implementation
def self.build_player(data)
  Player.new(
    id: data.fetch("PERSON_ID"),        # Required - raises if missing
    nickname: data["NICKNAME"]          # Optional - returns nil if missing
  )
end

# In tests - test both present AND missing
def test_handles_missing_nickname_key
  headers = all_headers.reject { |h| h == "NICKNAME" }
  row = build_row_without("NICKNAME")
  # ... stub request and assert attribute is nil
end
```

### Testing Predicate Methods

Test both true and false cases:

```ruby
def test_win_returns_true_when_wl_is_w
  log = GameLog.new(wl: "W")
  assert_predicate log, :win?
end

def test_win_returns_false_when_wl_is_l
  log = GameLog.new(wl: "L")
  refute_predicate log, :win?
end
```

### Testing Value Equality

Test with equivalent but different types to ensure `.eql?` is used:

```ruby
def test_made_uses_value_equality
  shot = Shot.new(shot_made_flag: 1.0)  # Float, not Integer
  assert_predicate shot, :made?
end
```

### Killing Surviving Mutants

When mutant reports surviving mutants, kill them by either:

1. **Adding tests** - Write a test that fails when the mutation is applied
2. **Replacing with the mutation** - If the mutated code is equivalent or better, adopt it

**Never ignore or exclude code from mutation testing.** Do not:
- Add exclusions to `.mutant.yml`
- Use inline `# mutant:disable` comments
- Skip methods or classes from mutation coverage

If a mutant seems impossible to kill, the code is likely untestable or redundant—refactor it instead of excluding it.

### Test Organization

Each test file must declare its coverage target:

```ruby
module NBA
  class MyFeatureTest < Minitest::Test
    cover MyClass  # Required for mutant coverage

    def test_something
      # ...
    end
  end
end
```

## Architecture Patterns

### Data Models

All models inherit from `Shale::Mapper` and include `Equalizer`:

```ruby
class Player < Shale::Mapper
  include Equalizer.new(:id)

  attribute :id, Shale::Type::Integer
  attribute :full_name, Shale::Type::String

  json do
    map "PERSON_ID", to: :id
    map "person_id", to: :id
    map "PersonID", to: :id  # Support multiple API formats
  end
end
```

### Query Modules

API endpoints are implemented as module class methods:

```ruby
module Players
  def self.find(player, client: CLIENT)
    id = Utils.extract_id(player)
    return unless id

    path = "commonplayerinfo?PlayerID=#{id}"
    ResponseParser.parse_single(client.get(path)) { |data| build_player(data) }
  end

  def self.build_player(data)
    Player.new(**identity_info(data), **physical_info(data))
  end
  private_class_method :build_player

  def self.identity_info(data)
    {id: data.fetch("PERSON_ID"), full_name: data.fetch("DISPLAY_FIRST_LAST")}
  end
  private_class_method :identity_info
end
```

### Collections

API methods returning multiple items return `Collection` objects (which are `Enumerable`).

### Lazy Hydration

Related objects are fetched lazily via methods, not in constructors:

```ruby
class Standing
  def team
    Teams.find(team_id)
  end
end
```

## Documentation Requirements

All public methods require YARD documentation with 100% coverage:

```ruby
# Returns whether the player is a Greatest 75 member
#
# @api public
# @example
#   player.greatest_75? #=> true
# @return [Boolean] true if in Greatest 75
def greatest_75?
  greatest_75_flag.eql?("Y")
end
```

## README Usage Examples

After implementing a new feature, add a usage example to the README. **Always
run the example code in a Ruby console to verify it works and produces the
expected output.**

### Process

1. Write the example code
2. Run it in IRB or a script against the live API:
   ```bash
   bundle exec irb -r nba
   ```
3. Capture the actual output values
4. Add the example to README.md with real, verified output

### Example Format

Follow the existing README style with comments showing actual return values:

```ruby
# Get player career stats
career = NBA::PlayerCareerStats.find(player: 201939)
career.size # => 16

season = career.last
season.pts # => 26.4
season.ast # => 6.1
```

### Why This Matters

- Examples with fabricated output erode user trust
- Live-tested examples catch API changes early
- Real data demonstrates actual library behavior
- Users can verify their setup works by comparing results

### When to Update

- Adding a new endpoint or query module
- Adding new model attributes or methods
- Adding new predicate methods
- Changing existing API behavior

## Quality Gates

All of these must pass before merging:
- `rake test` - 100% line and branch coverage
- `rake lint` - No RuboCop violations
- `rake mutant` - 100% mutation coverage (no surviving mutants)
- `rake steep` - No type errors
- `rake yardstick` - 100% documentation coverage
