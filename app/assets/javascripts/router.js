Consolidator.Router.map(function(){
    this.resource("things");
    this.resource("thing", { path: "/thing/:thing_id" }, function(){

    });
});
