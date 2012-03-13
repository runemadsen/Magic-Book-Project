/* Author: Miguel Bermudez
*/

(function(document){
	// Fix for iPhone viewport scale bug 
	// http://www.blog.highub.com/mobile-2/a-fix-for-iphone-viewport-scale-bug/
	if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
		var viewportmeta = document.querySelector('meta[name="viewport"]');
		if (viewportmeta) {
			viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0';
			document.body.addEventListener('gesturestart', function() {
				viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
			}, false);
		}
	};

	// Hide URL Bar for iOS
	// http://remysharp.com/2010/08/05/doing-it-right-skipping-the-iphone-url-bar/
	/mobile/i.test(navigator.userAgent) && !location.hash && setTimeout(function () {
	  window.scrollTo(0, 1);
	}, 1000);
})(document);







