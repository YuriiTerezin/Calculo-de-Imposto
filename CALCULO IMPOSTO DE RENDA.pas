Program IMPOSTO_RENDA ;
var
  Irbase1_1, Irbase1_2, Irbase2_1, Irbase2_2, Irbase3_1, Irbase3_2, Irbase4 : real;
  Inbase1, Inbase2_1, Inbase2_2, Inbase3_1, Inbase3_2, Inbase4_1, Inbase4_2 : real;
	
  aliquota1, aliquota2, aliquota3, aliquota4 : real;
  porcBase1, porcBase2, porcBase3, porcBase4 : real;
	
  resultBase1, resultBase2, resultBase3, resultBase4 : real;
  deducao1, deducao2, deducao3, deducao4 : real;
	
 salario, ir, inss, ir2, valorIr, valorIr2, valorDep, dep, result : real;
 liquido, irSimples, irFinal, valorFgts, fgts, valorTransp, vt : real;
 dependentes : integer;
 cont, transporte: char;

Begin

repeat

// Tabela de valores do IR
  Irbase1_1 := 2112.01;
  Irbase1_2 := 2826.65;
  Irbase2_1 := 2826.66;
  Irbase2_2 := 3751.05;
  Irbase3_1 := 3751.06;
  Irbase3_2 := 4664.68;
  Irbase4   := 4665.69;
  
// Valores do Imposto Simplificado e de Dependentes
  valorDep 	:= 189.59;
  irSimples := 528;
  
// Porcentagens de cada base
  aliquota1 := 7.5  / 100;
  aliquota2 := 15   / 100;
  aliquota3 := 22.5 / 100;
  aliquota4 := 27.5 / 100;
  
// Valor fixo para diminur o valor do desconto
  deducao1 := 158.4;
  deducao2 := 370.4;
  deducao3 := 651.73;
  deducao4 := 884.96;  
  
// Tabela de valores do INSS
  Inbase1   := 1412;
  Inbase2_1 := 1412.01;
  Inbase2_2 := 2666.68;
  Inbase3_1 := 2666.69;
  Inbase3_2 := 4000.03;
  Inbase4_1 := 4000.04;
  Inbase4_2 := 7786.02;

// Porcentagens de cada base do INSS
  porcBase1 := 7.5 / 100;
  porcBase2 := 9   / 100;
  porcBase3 := 12  / 100;
  porcBase4 := 14  / 100;
  
// Valores para a progreção de desconto
  resultBase1 :=  Inbase1 * porcBase1;
  resultBase2 := (Inbase2_2 - Inbase2_1) * porcBase2;
  resultBase3 := (Inbase3_2 - Inbase3_1) * porcBase3;
  resultBase4 := (Inbase4_2 - Inbase4_1) * porcBase4;
  
// Valor do FGTS
  fgts := 8 / 100;
	
// Valor do Vale Transporte
  vt := 6 / 100;
    
  writeln('Insira sua base de INSS e IR: ');
    read(salario);
  	
  writeln('Possui dependentes? Insira a quantidade: ');
    read(dependentes);
  	
  writeln('Você utiliza Vale Transporte? Digite " s " para confirmar: ');
    read(transporte);

  	
// Cálculo do INSS
  if (salario <= Inbase1) then
    inss := salario * porcBase1
  else if (salario >= Inbase2_1) and (salario <= Inbase2_2) then
    inss := ((salario - Inbase2_1) * porcBase2) + resultBase1
  else if (salario >= Inbase3_1) and (salario <= Inbase3_2) then
    inss := ((salario - Inbase3_1) * porcBase3) + resultBase1 + resultBase2
  else if (salario >= Inbase4_1) and (salario <= Inbase4_2) then
    inss := ((salario - Inbase4_1) * porcBase4) + resultBase1 + resultBase2 + resultBase3
  else if (salario >= Inbase4_2) then
    inss := resultBase1 + resultBase2 + resultBase3 + resultBase4;
  	
// Desconto de Vale Transporte
  if (transporte = 's') then
    valorTransp := salario * vt
  else
    salario := salario;
		
// Multiplica valor dos dependentes pela quantidade	
  dep := dependentes * valorDep; 
  
// Verifica se há dependentes para descontar
  if (dependentes >= 1) then
    ir := salario - inss - dep
  else if (dependentes = 0) then
    ir := salario - inss;
		
// Cálculo do Imposto de Renda
  if (ir >= Irbase1_1) and (ir <= Irbase1_2) then
    valorIr := (ir * aliquota1) - deducao1
  else if (ir >= Irbase2_1) and (ir <= Irbase2_2) then
    valorIr := (ir * aliquota2) - deducao2
  else if (ir >= Irbase3_1) and (ir <= Irbase3_2) then
    valorIr := (ir * aliquota3) - deducao3
  else if (ir >= Irbase4) then
    valorIr := (ir * aliquota4) - deducao4;
  	
// Cáculo do IR Simples
  ir2 := salario - irSimples;
	
  if (ir2 >= Irbase1_1) and (ir2 <= Irbase1_2) then
    valorIr2 := (ir2 * aliquota1) - deducao1
  else if (ir2 >= Irbase2_1) and (ir2 <= Irbase2_2) then
    valorIr2 := (ir2 * aliquota2) - deducao2
  else if (ir2 >= Irbase3_1) and (ir2 <= Irbase3_2) then
    valorIr2 := (ir2 * aliquota3) - deducao3
  else if (ir2 >= Irbase4) then
    valorIr2 := (ir2 * aliquota4) - deducao4;
	  
// Calculo do FGTS
  valorFgts := salario * fgts;

// Verifica qual o mais vantajoso pra o funcionáio  	
 if (valorIr > valorIr2) then
   irFinal := valorIr2
else
  irFinal := valorIr;

clrscr;
	
  writeln('');	
  writeln('Salário Base: R$ ', salario:0:2);
  
  writeln('');	
  writeln('Dependentes: ', dependentes);
  
  writeln('');
  writeln('Desconto de Inss: ', inss:0:2);
	
  writeln('');
  writeln('Contribuição de FGTS: ', valorFgts:0:2);
	
// Caso não tenha desconto de IR, mostra que não há valor a ser descontado
  writeln('');        
  if (ir <= Irbase1_1) and (ir2 <= irBase1_1) then
    writeln('Não há desconto de Imposto de Renda.')
  else	 	
    writeln('Desconto de Imposto de Renda: ', irFinal:0:2);
  	
  writeln('');
  writeln('Desconto de Vale Transporte: ', valorTransp:0:2);
  
  result := inss + irFinal + valorTransp;
  
  writeln('');
  writeln('Total de Descontos: R$ ', result:0:2);
  
  liquido := salario - result;
  
  writeln('');
  writeln('Salário líquido de: R$ ', liquido:0:2);
  
  writeln('');
		
  writeln('Deseja refazer o cálculo? Digite " s " para continuar...');
  read(cont);
	
  clrscr;
	
  until(cont <> 's');
     
End.
