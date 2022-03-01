# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

```
docker-compose -f docker-compose.yaml -f docker-compose.test.yaml exec web bundle exec rails test
```

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## start dev locally

```
docker-compose -f docker-compose.yaml -f docker-compose.dev.yaml up
```

- ...

docker-compose -f docker-compose.yaml -f docker-compose.dev.yaml exec web bundle exec

## run tests

docker-compose \
 -f docker-compose.yaml \
 -f docker-compose.dev.yaml \
 -f docker-compose.test.yaml \
 run --rm web bundle exec rails test

### assertions

https://minitest.rubystyle.guide/

|-------------------|-------------|
| Assertion Method | Description |
|-------------------|-------------|
| Assert(Test, Msg = Nil) | Fails Unless Test Is Truthy. |
| Assert_empty(Object, Msg = Nil) | Fails Unless Object Is Empty. |
| Assert_equal(Expected, Actual, Msg = Nil) | Fails Unless Exp == Act. |
| Assert_in_delta(Expected_float, Actual_float, Delta = 0.001, Msg = Nil) | Fails Unless Expected_float Is Within Delta Of Actual_float. |
| Assert_includes(Collection, Object, Msg = Nil) | Fails Unless Collection Includes Object. |
| Assert_instance_of(Klass, Object, Msg = Nil) | Fails Unless Object Is An Instance Of The Klass Class. |
| Assert_kind_of(Klass, Object, Msg = Nil) | Fails Unless Object Is A Kind Of Klass. (Note: Unlike Assert_instance_of, Which Checks The Object’s Class Directly, Assert_kind_of Considers The Object's Ancestors.) |
| Assert_match(Matcher, Object, Msg = Nil) | Fails Unless Matcher =~ Object. |
| Assert_nil(Object, Msg = Nil) | Fails Unless Object Is Nil. |
| Assert_raises(Exception_class, Msg) Do ... End | Fails Unless Block Raises An Exception Of Type Exception_class. |
| Assert_respond_to(Object, Method, Msg = Nil) | Fails Unless Object Responds To A Method Named Method. |
