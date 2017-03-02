var PerseidsCite;

PerseidsCite = PerseidsCite || {};

PerseidsCite.do_simple_query  = function() {

	$(".perseidscite_query_obj_simple").each(
		function() {
			var query_parent = this;
			var sbj = $(this).attr("data-sbj");
			var verb = $(this).attr("data-verb");
			var dataset = $(this).attr("data-set");
			var queryuri = $(this).attr("data-queryuri");
			var formatter = $(this).attr("data-formatter");

			// TODO default formatter ??
			
            if (!queryuri) { 
            	queryuri = $("meta[name='Perseids-Sparql-Endpoint']").attr("content");
 
           	}
			var dataset_query = "";
			if (dataset) {
				dataset_query = "from <" + dataset + "> "
			}
			if (queryuri && sbj && verb) {
				
				$.get(queryuri
					+ encodeURIComponent( 
						"select ?object "
	        			+ dataset_query
	        			+ "where { <" + sbj + "> " + "<"  + verb + "> ?object}")
	        		+ "&format=json", 
	        		function(data) {
	        			var results = [];
	            		if (data.results.bindings.length > 0) {
	                		$.each(data.results.bindings, function(i, row) {
	                			results.push(row.object.value);
	                		})
	            		}
	            		PerseidsCite[formatter](query_parent,verb,results);
				
	    			}, "json");
    		}	
			
    });
};

PerseidsCite.do_simple_result = function(a_elem,a_property,a_results) {
    for (var i=0; i<a_results.length; i++) {
        if (a_results[i].match('^https?:') != null) {
            $(a_elem).append('<p><a target="_blank" property="' + a_property + '" href="' + a_results[i] + '">' + a_results[i] + '</a></p>');
        } else {
            $(a_elem).append('<p><span property="' + a_property + '">' + a_results[i] + '</span></p>');
        }
    }
}


