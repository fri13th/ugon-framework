# ugon-framework

MVC Framework for Classic ASP

This code is for sample, not tested yet.
You can make your own framework by referencing this code.

There are two GET parameters. c for controller, m for method.
If you call /default.asp?c=main&m=index, main controller's index method is called.
You can use fancy URL, using URL Rewrite in IIS.
convert /main/index?params to /default.asp?c=main&m=index&params

The only problem in this framework is view part. 'include' in ASP doesn't support on-demain include. So it goes big and slow when there are many views in one controller.


I suggest to convert old asp code to new MVC Framework and after finishing to move, convert ASP MVC to PHP MVC. 
This code will be bridge to new framework.
