package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class jsCalendar{

		/**
		 * <inject_script>
		 * //var script = document.createElement("script");
		 * //------------ Core Minified -------------
		 * //script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.min.js");
		 * //script.setAttribute("integrity","sha384-0LaRLH/U5g8eCAwewLGQRyC/O+g0kXh8P+5pWpzijxwYczD3nKETIqUyhuA8B/UB");
		 * //script.setAttribute("crossorigin","anonymous");
		 * 
		 * //var link = document.createElement("link");
         * //link.setAttribute("href", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.min.css");
		 * //link.setAttribute("integrity","sha384-44GnAqZy9yUojzFPjdcUpP822DGm1ebORKY8pe6TkHuqJ038FANyfBYBpRvw8O9w");
		 * //link.setAttribute("crossorigin","anonymous");
		 * 
		 * //------------ Core Normal -------------
		 * //script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.js");
		 * //script.setAttribute("integrity","sha384-cmurOusLTBPJV2zIeQtv8E1MAZRuYEgcFNrOYCeNypDeHEhubywEwdyaguEkrDy4");
		 * //script.setAttribute("crossorigin","anonymous");
		 * 
         * //link.setAttribute("href", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.css");
		 * //script.setAttribute("integrity","sha384-IqymsN08KC67WHkPOiAlEL5w5cmUFIkVI/NR/j1QOYD6bzuZ/JdXGVTHa0sfWnci");
		 * //script.setAttribute("crossorigin","anonymous");
		 *  
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.js");
		 * document.head.appendChild(script);
		 * 
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "jscalendar/source/jsCalendar.css");
         * document.head.appendChild(link);
		 * 
		 * //------------ Optional Languages ------------- 
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.be.js" integrity="sha384-czOMAb4auqx/S7EgTYgb/Sb3xNKzvCN3heba5z2IR80vAI72y55KvGpYQMOJF0Ul" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ca.js" integrity="sha384-qzGOaC9zqJRFiV0hpjawSZ5AZyBN/5LfGURBE+pQVG6jZZG4hZjJI7l8ob7UUsfI" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.de.js" integrity="sha384-i0GkTTXTirBg3whOHw5AqlI80IINcvOfx2HjQ/x4uqJ+wsB465gvhaekGGxPlxVX" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.es.js" integrity="sha384-HnSecKq1jgs1/eJQQpOiIb4Wtq7hlMC6nsooaNN+1JPTdzYSbiMP9f8xqKjque1e" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.fr.js" integrity="sha384-Ob75mVgpo9t5GyveJWKmg21yW1VCLgGe15lpXGHPbfizJmbuG0JnxdwOg7sbYelv" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.gr.js" integrity="sha384-PRRiiI0gLDo7hU5jD+aJQxbUSjjXHJeL0CdFAynqIWD9XATAYPQpKQkwrqjM+b8t" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.hu.js" integrity="sha384-yP2k8rRYSOiAc2PfxQ/WAFjMVRoA8AMxGZhlutbHXDc9vGMeokM2qyF2fLHaGPxo" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.it.js" integrity="sha384-3PiSuWThRXpAvOjasZXyIrVl5H2x296VPhp9D0NebW9V5rcHzCSx4Dh5WRd+pQVO" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ja.js" integrity="sha384-O/JkPTslqFkNst65hIikWD7NVsNBRN2vGvprEt9n9tXPKFwocawTwKvwAnPOOZRc" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.nl.js" integrity="sha384-pitfgw0cn6lUL67KU0jVykK7GIZnS0xqH4nBIIgGo6rSSADgyHdWfoDvoR78juHd" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.no.js" integrity="sha384-exBlQuh0Apw5DoBAJVxPYJRKYrQjOScXHmQHX9ZA/jZb92Ec6NQjOddl/GexPkCS" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.pt.js" integrity="sha384-NF3X/E9s0p9PqeJxs+kx2xFHOAfiuNlGpIiwzLBET1Y0pejnfmOm5DJhn6ioTpCr" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ru.js" integrity="sha384-xVQY3RcL7F/s9lcv9KNRyquT4kypFWf4OsQPGvpOcB70qhCvQ5P5KdhSygsc6GQg" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.sk.js" integrity="sha384-fusvqbkUQKgP3X7NX3lUxQEc5yG0V1vbZx8q246R4Bsl/Mzichrn3n8rOWOvJpSB" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.sv.js" integrity="sha384-fisTE5VLKPsxo5RbFtTLJ1T0j6y8a3SlylIzHZaXSErsJNIy3P82uGhomnRoPc4m" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.tr.js" integrity="sha384-9u6ZxP0FkigNhAYvsyxqA97/kjtLLv3cdS5isu5KP/vjQlguqdG76uS4UOEoNk7y" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.uk.js" integrity="sha384-tVzYxj0/QLUOY8QNd3YSzik+Zi4ShGbZTMd72rTA3xTtQMyrFquKRPsp1nsZdMJl" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.zh.js" integrity="sha384-V0QPacMFDmO6dM4PsEqgwCew+6CzJCk0LaaL/cRM1+LQZjoh5GH64OHX+RNLuORd" crossorigin="anonymous">
		 * 
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.be.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.ca.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.de.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.es.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.fr.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.gr.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.hu.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.it.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.ja.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.nl.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.no.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.pt.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.ru.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.sk.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.sv.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.tr.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.uk.js");
		 * document.head.appendChild(script);
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.lang.zh.js");
		 * document.head.appendChild(script);
		 * 
		 * //------------ Optional Themes ------------- 
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.clean.min.css" integrity="sha384-KVMZD/q6PZDK3xYHB7uJwJbE8VGNCaJWAQQ+9i/MsP8VV4eLGQdJRzHjfVACCBMU" crossorigin="anonymous">
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.clean.css" integrity="sha384-ICEMsS1kLS8RctRzIh3D3wXGIGNXdAeq/Cox8tRla+pje3WXoVOd+J0LR7AFXt9q" crossorigin="anonymous">
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.darkseries.min.css" integrity="sha384-ZbdiJ7QkbjnGdb+XFoRs+hUWQqmkaWxNaczaUzb8rhUIl+D+ZaAiqpxse5Nn/rBk" crossorigin="anonymous">
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.darkseries.css" integrity="sha384-1WOpRS9VWHABAzTAZ4pqBzNb+4UGfNq6qvWoz6ROv89xiHFu0SDj8WGIcQo584Jr" crossorigin="anonymous">
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.micro.min.css" integrity="sha384-aOgaUk5MAJeF3DMxm62ZLQdwcwGJHAL+x2HKDLeL0KGzq58mbx1NmWBufXj6av+T" crossorigin="anonymous">
		 * //<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/themes/jsCalendar.micro.css" integrity="sha384-trm9scV3zUQrRLK6sHRClCHa7P/k5N9ZJVRx9UlyE3BZUcont3CLSSC80VWlKXCj" crossorigin="anonymous">
		 
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "jscalendar/themes/jsCalendar.clean.css");
         * document.head.appendChild(link);
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "jscalendar/themes/jsCalendar.darkseries.css");
         * document.head.appendChild(link);
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "jscalendar/themes/jsCalendar.micro.css");
         * document.head.appendChild(link);
		 * 
		 * //------------ Optional Extensions ------------- 
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/extensions/jsCalendar.datepicker.min.js" integrity="sha384-+kCc/DUyMCZKRKBUju8rYWlpPstskB0TMl/gO6Qu1yDvtdZTdKBWUv8slo8vn7x/" crossorigin="anonymous">
		 * //src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/extensions/jsCalendar.datepicker.js" integrity="sha384-A9jyu6xqyitRcMEZEgHbi1znFOFMSqCCD/Htdwy7QCbR6Yw3FDygm8qgpLJx1VG0" crossorigin="anonymous">
		 * 
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/extensions/jsCalendar.datepicker.js");
		 * document.head.appendChild(script);
		 * 
		 * </inject_script>
		*/
        public function jsCalendar(){
		}
		
	}
}