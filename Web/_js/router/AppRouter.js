/* globals Settings:true */

var AppRouter = Backbone.Router.extend({

	initialize: function(){
		_.bindAll.apply(_, [this].concat(_.functions(this)));
	},

	routes: {
		"": "overview",
		"*path":  ""
	},

	render: function(){
		
	}
});
