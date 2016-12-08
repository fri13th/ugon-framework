# ugon-framework

MVC Framework for Classic ASP

To use clasic ASP in product is to move a mountain using only a shovel.

This code is for sample, not tested yet.
You can make your own framework by referencing this code.

There are two GET parameters. c for controller, m for method.
If you call /main.asp?c=main&m=index, main controller's index method is called.
You can use fancy URL, using URL Rewrite in IIS.
convert /main/index?params to /main.asp?c=main&m=index&params


The only problem in this framework is view part. 'include' in ASP doesn't support on-demain include. So it goes big and slow when there are many views in one controller.


I suggest you to convert old ASP to new ASP MVC Framework and after finishing to move, convert ASP MVC to PHP MVC, PHP works with IIS very well.
This piece of code will be bridge to new framework.
