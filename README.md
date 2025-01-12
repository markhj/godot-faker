# Godot Faker

![GitHub Tag](https://img.shields.io/github/v/tag/markhj/godot-faker?label=version)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?label=license)

**_Godot Faker_** is a mock data utility which generates realistic(-looking)
information &mdash; such as first and last names &mdash; within the context of
a select language.

It's useful for games, in which you have to procedurally generate entities within
a language context, such as names or cities.

## 💫 Prerequisites

- Godot 4.3 or higher

## 🚀 Installation

> Add-on is not yet distributed as an official repository.

The most straight-forward way to install an add-on which is not yet published
on the official Godot repository, is good old copy/paste.

Download the source code and extract it.
Then copy ``addons/godot-faker`` to the identical location in your project.
Do _not_ copy the other files, such as the ``tools`` folder.

Last step is to activate the plugin under **Project Settings &rarr; Addons**.

## ▶️ Getting started

Once the addon is active, you will have access to the ``Faker`` class.
In most use-cases, you will just need a single instance, so let's go ahead
and instantiate it:

````GDScript
var faker: Faker = Faker.new()
````

Let's start simple, and generate a random first name, where we don't care
whether it's male or female.

````GDScript
var first_name: String = faker.first_name()
````

### Gender

You can specifically request a male or female name, by prepending the
call to respective methods:

````GDScript
var first_name: String = faker.female().first_name()
````

And, you could of course use ``male`` instead.

## 🌍 Locale

You can set a specific locale using ``set_locale``.
You can set it universally for the ``Faker`` instance, like this:

````GDScript
faker.set_locale("da_DK")
````

You can also specifically set during a use-case.
Below, we're getting a Danish female first name:

````GDScript
var first_name: String = faker.set_locale("da_DK").female().first_name()
````

> Warning: If the locale doesn't exist the app will be interrupted
> with a critical error.

## 🔖 Names

You can generate first name, name or full name:

| Method         | Description                                      |
|----------------|--------------------------------------------------|
| ``first_name`` | Generates a first name (to gender, if specified) |
| ``last_name``  | Generates a last name (to gender, if specified)  |
| ``full_name``  | Generates a full name (to gender, if specified)  |

## ⌛ What happens next?

The plan is to add more locales, as well as more entities which can be
randomized, such as cities, internet addresses, etc.
