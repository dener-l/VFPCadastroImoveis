public class ImobiliariaController {
    
    //Definiçoes das variáveis
    
    public integer quartos{get; set;}
    public integer banheiros{get; set;}
    public integer sala{get; set;}
    public integer cozinha{get; set;}
    public integer copas{get; set;}
    public integer valor{get; set;}
    public String tipoImovel{get; set;}
    
    //Método picklist
    public list<SelectOption> getMinhasOpcoes(){
        //Mapear o campo de lista de seleção/picklist que desejo listar
        Schema.DescribeFieldResult describeResult = Imoveis__c.TipoImovel__c.getDescribe();
        
        //listar as opções válidas dentro do meu campo
        List<Schema.PicklistEntry> entries = describeResult.getPicklistValues();
        
        //Cria variável de retorno do tipo de lista para o objeto SelectOption
        List<SelectOption> optionsToReturn = new List <SelectOption>();
        
        //Adiciona as opções do campo listadas
        for(Schema.PicklistEntry pEntry : entries){
            
            //se a opção esta ativa
            //Ou pode aplicar o filtro que quiser, caso não queira mostrar todas as opções
            if(pEntry.isActive()){
                //Adiciona o nome e o valor na variável retorno
                optionsToReturn.add(new SelectOption(pEntry.getValue(), pEntry.getLabel()));
            }
        }
        return optionsToReturn;
    }
    
    //Método salvar
    public void salvarImoveis(){
        Imoveis__c objImoveis = new Imoveis__c();
        objImoveis.Quartos__C = quartos;
        objImoveis.Banheiro__C = banheiros;
        objImoveis.Sala__C = sala;
        objImoveis.Cozinha__C = cozinha;
        objImoveis.Copas__C = copas;
        objImoveis.Valor__C = valor;
        objImoveis.TipoImovel__c = tipoImovel;
        
        try{
            
            if(objImoveis.TipoImovel__c != 'Nenhum' && objImoveis.TipoImovel__c != null){
                
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Imóvel cadastrado com sucesso!'));
                insert objImoveis;
                
                //Limpa os campos após salvar
                quartos = null;
                banheiros = null;
                sala = null;
                cozinha = null;
                copas = null;
                valor = null;
                tipoImovel = null;
                
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'O campo Tipo do Imóvel deverá ser preenchido!'));
            }
            
        }catch(DmlException e){
            
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'O campo Tipo do Imóvel deverá ser preenchido!'));
            
        }
        
        
        
    }
}