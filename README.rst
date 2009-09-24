NGX-Rome
--------

Summary
~~~~~~~

This is a module for nginx that allows for the delivering of partitioned files.
Rome refers to the Roman empire's occasional strategy of "Divide and Conquer."
If a document that you want to serve up to the connection can be thought of as
a static part, then a small dynamic part, then more static stuff, ngx-rome
would allow you to partition those out and serve them up serially.  In this
sense it's an alternative to SSI, which can be used to do the same thing, only
it works much, much faster than SSI for this purpose.
