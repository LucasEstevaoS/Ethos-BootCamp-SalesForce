//trigger pode ser before ou after
//podem ser acionadas no insert, update, delete, undelete /*
/*trigger OrdemTrigger on Ordem__c (before insert, before update) {
    Ordem__c ordemFoda = trigger.new[0];
    
    if(trigger.isInsert){
    //calculo do total
        if(ordemFoda.Total__c == null){
            if(ordemFoda.Preco__c != null && ordemFoda.Quantidade__c != null){
                ordemFoda.Total__c = ordemFoda.Quantidade__c * ordemFoda.Preco__c;
            }else{
                ordemFoda.adderror('Os valores de quantidade e preço não foram preenchidos!');
            }
        }

        //calculo da quantidade
        else{
            if(ordemFoda.Preco__c != null){
                ordemFoda.Quantidade__c = ordemFoda.Total__c / ordemFoda.Preco__c;
            }else{
                ordemFoda.adderror('Os valores de total e preço não foram preenchidos');
            }       
        }
    }else{
        Ordem__c ordemMerda = trigger.oldMap.get(ordemFoda.id);
        //erro de alteracao do total
        if(ordemMerda.Total__c != ordemFoda.Total__c && ordemFoda.Total__c != (ordem.Foda.quantidade__c * ordemFoda.Preco__c)){
            ordemFoda.adderror('O total não pode ser alterado manualmente depois que a ordem foi criada');
        }
        //Recalculo do total
        if(ordemMerda.Quantidade__c != ordemFoda.Quantidade__c || ordemMerda.Preco__c != ordemFoda.Preco__c){
            ordemFoda.Total__c = ordemFoda.Quantidade__c * ordemFoda.Preco__c;            
        }
    }
}*/

trigger OrdemTrigger on Ordem__c (before insert, before update) // before ou after -- insert, update, delete, undelete
{ 
    new OrderTriggerHandler().run();
}