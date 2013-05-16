Consolidator.ThingController = Ember.ObjectController.extend({
    requestable: function(){
        var user = Consolidator.currentUserController;
        if(this.get("holder") === user){
            return "holder";
        }

        var stake = Consolidator.Stake.find({user: user.get("id"), thing: this.get("id")});
        if(stake){
            return "owned";
        }
        return "requestable";
    }.property()
});