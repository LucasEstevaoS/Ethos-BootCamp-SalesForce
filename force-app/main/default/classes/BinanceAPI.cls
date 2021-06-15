//with sharing - so os papeis vao ter acesso
//without sharing - todos tem acesso

public class BinanceAPI {
    @AuraEnabled //pega metodos visiveis javascript
    //para conseguir chamar no java script tem que ter assinatura e metodo static

    public static String getPrice(String mercadoId){
        Criptofalidos__Mercado__c mercado = [SELECT Id, Criptofalidos__MoedaPrimaria__c, Criptofalidos__MoedaSecundaria__c
                                            FROM Criptofalidos__Mercado__c
                                            WHERE Id = :mercadoId];
        
        String pair = mercado.Criptofalidos__MoedaPrimaria__c + mercado.Criptofalidos__MoedaSecundaria__c;
        pair = pair.replace('USD', 'USDT');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price?symbol=' + pair);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        
        if(response.getStatusCode()== 200){
            SymbolPrice sp = (SymbolPrice)JSON.deserialize(response.getBody(), SymbolPrice.class);
            return sp.price;
        }else{
            return 'Erro ao acessar a API da Binance!';
        }
    }
    private Class SymbolPrice{
        String symbol;
        String price;
    }
}
