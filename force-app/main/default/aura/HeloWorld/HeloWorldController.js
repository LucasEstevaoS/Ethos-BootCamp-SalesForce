({
    handleClick : function(component, event, helper) {
        var uName = component.get("v.nome");
        alert("Bem vindo " + uName);
        //setar a variavel para vazio, em tela
        component.set("v.nome", "");
       
    }
})
