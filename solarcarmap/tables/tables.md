# Tables in LiveLabs

## Introduction

This lab shows how to format Markdown tables and customize their captions.

Estimated Time: Varies by environment and experience.

### Objectives

* Define a Markdown table with left, center, and right column alignment.
* Add a custom table title and inspect the rendered caption.

## Tables are cool

You can define a table in Markdown just like so:

```
| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| **col 3 is**  | right-aligned | $1600 |
| col 2 is      |  *centered*   |   $12 |
| zebra stripes | ~~are neat~~  |    $1 |
```

The result looks like this:

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| **col 3 is**  | right-aligned | $1600 |
| col 2 is      |  *centered*   |   $12 |
| zebra stripes | ~~are neat~~  |    $1 |

You can see that there is a default table caption provided which is by default a concatenation of the workshop title and the lab title.

If you don't like the default, you can also provide your own table title by adding the below the table definition:

```
{: title="My table title"}
```

The complete markdown looks like this:

```
| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| **col 3 is**  | right-aligned | $1600 |
| col 2 is      |  *centered*   |   $12 |
| zebra stripes | ~~are neat~~  |    $1 |
{: title="My table title"}
```

Now our table looks like this:

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| **col 3 is**  | right-aligned | $1600 |
| col 2 is      |  *centered*   |   $12 |
| zebra stripes | ~~are neat~~  |    $1 |

*My table title*

As you can see, the numbering is added automatically.

Isn't that cool?

You can also refer to the [LiveLabs Markdown Cheatsheet](https://objectstorage.us-ashburn-1.oraclecloud.com/p/4Au3jJ-t8Wtw3LWyYsDMqQk2FdlXDvXCb1MYRS0J6P4QS-GCrv2YNOolWdtFMLZq/n/c4u04/b/livelabsfiles/o/labfiles/LiveLabs_MD_Cheat_Sheet.pdf)

## Acknowledgements

See the [workshop credits](../introduction/introduction.md#acknowledgements).
