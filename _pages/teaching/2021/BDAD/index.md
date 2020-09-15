---
layout: page
title: Databases (BDAD - MIEIC)
permalink: /teaching/2021/BDAD/
crumbtitle: BDAD
tags: teaching databases feup exercises sql
---


{% include danger.html content="These solutions are not the official ones.<br><br>Always compare with the official alternatives and use critical sense in choosing which may be the best, as there are always many ways to solve the same problem.<br><br>If you find any mistakes or have questions, please [drop me an email](mailto:joaorosilva@gmail.com).<br><br>In alternative you can file a pull request by yourself [here](https://github.com/silvae86/silvae86.github.io)" %}

## "Tuned" scripts with more edge cases

[Oficina/Workshop]({% link _pages/teaching/2020/BDAD/scripts/oficina_with_ties.sql %})

- More than one most expensive repair to test whether or not your queries return more than one repair with the maximum cost.
- Second-most costly repair: 2 repairs also tied

## SQL DML

### Faculdade

#### 1. Quais os números	dos alunos?

```sql
select nr FROM Aluno;
```

#### 2. Qual	o	código	e	designação	das	cadeiras	do	curso	'AC'?

```sql
select cod, Design FROM cadeira where curso='AC';
```

#### 3. Existem	nomes	comuns	a	alunos	e	profs?	Quais?

```sql
select nome from aluno intersect select nome from prof;
```

#### 4. Quais	os	nomes	específicos	dos	alunos,	i.e.,	que	nenhum	professor	tem?

```sql
select nome from aluno except select nome from prof;
```

#### 5. Quais	os	nomes	das	pessoas	relacionadas	com	a	faculdade?

```sql
select nome from aluno union select nome from prof;
```

#### 6. Quais	os	nomes	dos	alunos	que	fizeram	alguma	prova	de	'ts1'?

```sql
select nome
from aluno
join
(
  select distinct nr from prova where cod='TS1'
) as codigos_dos_alunos
on aluno.nr = codigos_dos_alunos.nr;
```

```sql
select nome
from aluno
join
(
    select distinct aluno.nr
    from aluno join
    (
        select aluno.nr, prova.cod
        from aluno join prova on aluno.nr = prova.nr
    ) as codigos_dos_alunos
    on aluno.nr = codigos_dos_alunos.nr
    where cod = 'TS1'
) as codigos_dos_alunos2
on aluno.nr = codigos_dos_alunos2.nr;
```

```sql
SELECT nome
  FROM aluno
       JOIN
       (
           SELECT DISTINCT (aluno.nr),
                           nome
             FROM aluno
                  JOIN
                  prova ON aluno.nr = prova.nr
            WHERE cod = 'TS1'
       )
       AS codigos_dos_alunos ON aluno.nr = codigos_dos_alunos.nr;
```

#### 7. Quais	os	nomes	dos	alunos	com	inscrição	no	curso	'IS'?

```sql
select distinct(aluno.nome)
from Aluno, Cadeira, Prova
where
    Aluno.nr = Prova.nr and Prova.cod = Cadeira.cod
    and Cadeira.curso = 'IS';
```

#### 8. Qual	a	relação	dos	nomes	dos	alunos	que	concluíram	o	curso	'IS'.



#### 9. Qual	a	nota	máxima	existente	nas	provas?

```sql
select cod, max(nota) from Prova;
```

#### 10. Qual	a	nota	média	nas	provas	de	BD?

```sql
select avg(nota) as media_de_bd from prova where cod='BD';
```

#### 11. Qual	o	número	de	alunos?

```sql
select count(*) from aluno;
```

#### 12. Qual	o	número	de	cadeiras	de	cada	curso?

```sql
select curso, count(*) as num_cadeiras
from cadeira
group by curso;
```

#### 13. Qual	o	número	de	provas	de cada	aluno?

```sql
select nr, count(*) as num_provas
from prova
group by nr;
```

#### 14. Qual	a	média	do	número	de	provas	por	aluno?

```sql
select avg(num_provas)
from
(
    select count(*) as num_provas
    from prova
    group by nr
);
```

```sql
-- alternativa para calcular media de
-- numero de provas por cadeira (por curiosidade,
-- variação do exercício proposta na aula por aluno)
--

select cod, avg(num_provas) num_medio_provas
from
(
    select nr, cod, count(*) as num_provas
   from prova
   group by nr, cod
)
group by cod;
```

#### 15. Qual	o	nome	e	respetiva	média	atual	(cadeiras	feitas,	em	qualquer	curso)	de
cada	aluno?

```sql
select nome, avg(max_nota) as media
from
(
    select nome, cod, max(nota) as max_nota
    from prova join aluno on prova.nr = aluno.nr
    where prova.nota >= 10
    group by nome, cod
)
group by nome;
```

#### 16. Qual	a	nota	máxima	de	cada	cadeira	e	qual	o	aluno	que	a	obteve?

```sql
select alunos_com_notas_maximas.cod, nome, max_nota
from aluno
join
(
    select prova.cod, nr, max_nota
    from prova,
    (
        select cod, max(nota) as max_nota
        from prova
        group by cod
    ) as notas_maximas
    where
        prova.cod = notas_maximas.cod
    and
        prova.nota = max_nota
) as alunos_com_notas_maximas
on aluno.nr = alunos_com_notas_maximas.nr;
```

#### 17. Obtenha	a	relação	ordenada	por	curso	dos	nomes	dos	alunos	formados

Para este exercício há (pelo menos) duas alternativas. Podemos utilizar subqueries/views ou então uma subquery correlacionada ([correlated subquery](https://www.geeksforgeeks.org/sql-correlated-subqueries/)). Recomendo ler esse link porque explica a lógica da subquery correlacionada, como que fosse uma "função" de validação de cada tuplo da query principal. Só os tuplos que passarem a "validação" pela subquery serão incluídos na query principal.
Na abordagem sem query correlacionada, o raciocínio é mais parecido com algebra relacional, em que partimos de um resultado de uma query e vamos aplicando mais restrições/joins até obtermos o resultado pretendido.

Na abordagem sem query correlacionada, as queries mais internas podem ser corridas independentemente, pois não têm "variáveis" ou "parâmetros" definidos nas queries mais externas.

**Alternativa 1  (Views)**

```sql
---Divisao
---A -> a,b
---B -> b
---A \ B -> a

--cadeiras de cada curso
drop view if exists cadeiras_de_curso;
create temp view cadeiras_de_curso as
select cod, curso
from cadeira;

--provas positivas
drop view if exists provas_positivas;
create temp view provas_positivas as
select nr, cadeira.cod, curso
from prova join cadeira on prova.cod = cadeira.cod
where nota >=10;

--dividir provas positivas por cadeiras do curso
--os tuplos que sobrarem sao os valores de nr
--que tem todos os tuplos das cadeiras de um curso

select distinct nr, nome, curso
from aluno, cadeiras_de_curso
where (nr, curso)
not in
(
    -- cursos que cada aluno nao fez
    -- se tiver falhado pelo menos
    -- uma cadeira do curso, nao o fez
    -- (nao importa que cadeira tenha falhado!)
    select nr, curso
    from
    (
        -buracos dos alunos
        select nr, cod, curso
        from aluno, cadeiras_de_curso
        except
        select nr, cod, curso
        from provas_positivas
    )
)
```

**Alternativa 2  (Correlated Query)**

```sql
--objetivo
--nr_aluno | curso concluido

---(com query correlacionada)

---seleccionar os alunos e cursos...
select nr as nr_aluno, curso as curso_concluido
from aluno, cadeira c
where
not exists
(
    ---... onde nao exista nenhum buraco (cadeira nao feita)
    ---para aquele curso e aluno especificado como
    ---argumento na query exterior

    ---para todas as cadeiras do curso e dado aquele aluno.......
    select nr, cod
    from aluno, cadeira
    where aluno.nr = nr_aluno and curso = curso_concluido
    except
    ---.......extrair as provas positivas
    select nr, prova.cod
    from prova join cadeira on prova.cod = cadeira.cod
    where prova.nr = nr_aluno and cadeira.curso = curso_concluido
    and nota >=10
    ---... para obter os "buracos" (cadeiras por fazer
    ---por aquele aluno naquele curso)
)
```

#### Oficina

#### a. Quais	as	peças	com	custo	unitário	inferior	a	10€	e	cujo	código	contém	‘98’?

```sql
select idPeca
from peca
where
	custoUnitario < 10
and
	codigo like '%98%';
```

#### b. Quais	as	matrículas	dos	carros	que	foram	reparados	no	mês	de	Setembro	de 2010,	i.e.,	cuja	reparação	terminou	nesse	mês?

```sql
select matricula
from
carro join reparacao
on
reparacao.idCarro = carro.idCarro
where
strftime('%m', dataFim) = '09' and strftime('%Y', dataFim) = '2010';
```

#### c. Quais	os	nomes	dos	clientes	proprietários	de	carros	que	utilizaram	peças com	custo	unitário	superior	a	10€?	Apresente	o	resultado	ordenado	por ordem	descendente	do	custo	unitário.

```sql
select nome
from
Reparacao
join
(
	select idReparacao, custoUnitario
	from reparacaoPeca join Peca on reparacaoPeca.idPeca = Peca.idPeca
	where Peca.custoUnitario > 10
) as rep_pecas_caras
on Reparacao.idReparacao = rep_pecas_caras.idReparacao
join Carro
on Reparacao.idCarro = Carro.idCarro
join Cliente
on Carro.idCliente = Cliente.idCliente
order by custoUnitario DESC;
```


#### d. Quais	os	nomes	dos	clientes	que	não	têm	(tanto	quanto	se	saiba)	carro?


```sql
-- select nome from Cliente
-- where Cliente.idCliente
-- not in
-- (
-- 	select idCliente from Carro
-- );

select nome
from Cliente
join
(
	select idCliente  
	from Cliente
	except
	select
	idCliente
	from Carro
) as clientes_sem_carro
on Cliente.idCliente = clientes_sem_carro.idCliente;
```

#### e. Qual	o	número	de	reparações	feitas	a	cada	carro?

```sql
-- Objetivo
-- idCarro | n_reparacoes

select matricula, n_reparacoes as 'Num Reparacoes'
from
(
	select idCarro, count(*) as n_reparacoes
	from Reparacao
	group by idCarro
) as n_rep_por_carro
join Carro
on n_rep_por_carro.idCarro = Carro.idCarro;

-- select matricula, count(*) as 'Num Reparacoes'
-- from Reparacao
-- join Carro on Carro.idCarro = Reparacao.idCarro
-- group by Matricula;
```

#### f. Qual	o	número	de	dias	em	que	cada	carro	esteve	em	reparação?

```sql
-- Solução inicial proposta (tem bug no caso de um carro entrar no final de um mes e sair no inicio de outro)

-- strftime('%d', dataFim) - strftime('%d', dataInicio)
--
-- Data Inicio - Data Fim
-- 2020-01-29 -> 2020-02-01

-- select idReparacao, strftime('%d', dataFim) - strftime('%d', dataInicio)
-- from Reparacao;
```


```sql
--- Solução com julian day, resolve bug da solução anterior
--- Matricula | n total de dias em reparacao

select matricula, total_horas as "n total de dias em reparacao"
from Carro
join
(
	-- usar julianday para lidar com datas de fim com dias (1-31) inferiores ao dia do inicio da reparação, mas num mes posterior.
	select idCarro, sum(julianday(dataFim) - julianday(dataInicio)) as total_horas
	from Reparacao
	group by idCarro
) as horas_totais_por_carro
on horas_totais_por_carro.idCarro = Carro.idCarro;
```

#### g. Qual	o	custo	unitário	médio,	o	valor	total	e	o	número	de	unidades	das	peças, bem	como	o	valor	da	peça	mais	cara	e	da	mais	barata?

```sql
--- Media | Val Total | Num Unidades | Val. Mais Cara | Valor Mais Barata

select
avg(custoUnitario) as Media,
sum(custoUnitario * quantidade) as 'Val Total',
count(*) as 'No de tipos de pecas',
min(custoUnitario) as 'Preco Minimo',
max(custoUnitario) as 'Preco Maximo'
from Peca;
```

#### h. Qual	a	especialidade	que	foi	utilizada	mais	vezes	nas	reparações	dos	carros de	cada	marca?

```sql
-- Obj Final
-- Marca | Especialidade Mais Usada


-- Especialidades usadas em cada reparacao
-- Marca | idEspecialidade | n_reparacoes

drop view if exists EspecialidadesMarca;
create view EspecialidadesMarca as
select Marca.nome as Marca,
	esp_das_rep.idEspecialidade as idEspecialidade,
	count(Reparacao.idReparacao) as n_reparacoes
from
(
	select FuncionarioReparacao.idReparacao as idReparacao, Funcionario.idEspecialidade
	from Funcionario
	join FuncionarioReparacao
	on Funcionario.idFuncionario = FuncionarioReparacao.idFuncionario
	order by idReparacao
) as esp_das_rep
join Reparacao on esp_das_rep.idReparacao = Reparacao.idReparacao
join Carro
on Reparacao.idCarro = Carro.idCarro
join Modelo
on Carro.idModelo = Modelo.idModelo
join Marca
on Modelo.idMarca = Marca.idMarca
group by Marca.nome, esp_das_rep.idEspecialidade;

-- especialidade mais usada em cada marca
select *
from EspecialidadesMarca
where (Marca, n_reparacoes)
in
(
	select Marca, max(n_reparacoes)
	from 	EspecialidadesMarca
	group by Marca
);
```


#### i. Qual	o	preço	total	de	cada	reparação?

```sql
-- | idReparacao | custoTotal (= custoPecas + custoMaoObra) |

-- | idReparacao | custoMaoObra |
-- | idReparacao | custoPecas |
-- | idReparacao | custoMaoObra | custoPecas |

drop view if exists custoMaoObra;
create view custoMaoObra as
	select Reparacao.idReparacao, coalesce(custoMaoObra, 0) as custoMaoObra
	from
	Reparacao
	left join
	(
		select idReparacao, sum(custoHorario * numHoras) as custoMaoObra
		from FuncionarioReparacao
		join Funcionario on 		FuncionarioReparacao.idFuncionario = 		Funcionario.idFuncionario
		join Especialidade on Funcionario.idEspecialidade 	= Especialidade.idEspecialidade
		group by idReparacao
	) as custosMaoObra on custosMaoObra.idReparacao = Reparacao.idReparacao;

drop view if exists custoPecas;
create view custoPecas as
	select Reparacao.idReparacao, coalesce(custoPecas, 0) as custoPecas
	from
	Reparacao
	left join
	(
		select idReparacao, sum(ReparacaoPeca.quantidade * Peca.custoUnitario) as custoPecas
		from ReparacaoPeca join Peca on ReparacaoPeca.idPeca = Peca.idPeca
		group by idReparacao
	) as custosPecas on custosPecas.idReparacao = Reparacao.idReparacao;

--	idReparacao | CustoReparacao
--	1			| 20
--	2			| 0

drop view if exists custosReparacoes;
create view custosReparacoes as
	select custoPecas.idReparacao, custoPecas.custoPecas + custoMaoObra.custoMaoObra as custoTotal
	from custoPecas join custoMaoObra
	on custoPecas.idReparacao = custoMaoObra.idReparacao;

select * from custosReparacoes;
```

```sql
-- | idReparacao | custoTotal (= custoPecas + custoMaoObra) |

-- | idReparacao | custoMaoObra |
-- | idReparacao | custoPecas |
-- | idReparacao | custoMaoObra | custoPecas |

drop view if exists custoMaoObra;
create view custoMaoObra as select idReparacao, sum(custoHorario * numHoras) as custo
		from FuncionarioReparacao
		join Funcionario on 		FuncionarioReparacao.idFuncionario = 		Funcionario.idFuncionario
		join Especialidade on Funcionario.idEspecialidade 	= Especialidade.idEspecialidade
		group by idReparacao;

drop view if exists custoPecas;
create view custoPecas as
	select idReparacao, sum(ReparacaoPeca.quantidade * Peca.custoUnitario) as custo
	from ReparacaoPeca join Peca on ReparacaoPeca.idPeca = Peca.idPeca
	group by idReparacao;

drop view if exists custosReparacoes;
create view custosReparacoes as
	select Reparacao.idReparacao, coalesce(sum(custo), 0) as custoTotal
	from
	Reparacao
	left join
	(
		select * from custoMaoObra union select * from custoPecas
	) as custosTotais
	on Reparacao.idReparacao = 	custosTotais.idReparacao
	group by Reparacao.idReparacao;

select * from custosReparacoes;
```







#### j. Qual	o	preço	total	das	reparações	com	custo	total	superior	a	60€?

```sql
--- fazer read da i.sql para ter a view com o custo total das reparacaoes.

select *
from custosReparacoes
where custoTotal > 60;
```

#### k. Qual	o	proprietário	do	carro	que	teve	a	reparação	mais	cara?


```sql
-- | nome |

-- select *
-- from custosReparacoes
-- where custoTotal =
-- (
--
-- );


select Cliente.nome, custosReparacoes.idReparacao, custoTotal as custoTotal
from custosReparacoes
join Reparacao on custosReparacoes.idReparacao = Reparacao.idReparacao
join Carro on Carro.idCarro = Reparacao.idCarro
join Cliente
on Carro.idCliente = Cliente.idCliente
where custoTotal = (
	select max(custoTotal) from 	custosReparacoes
);
```

#### l. Qual	a	matrícula	do	carro	com	a	segunda	reparação	mais	cara?


```sql
-- | nome |

-- select *
-- from custosReparacoes
-- where custoTotal =
-- (
--
-- );


select Carro.matricula, custosReparacoes.idReparacao, custoTotal as custoTotal
from custosReparacoes
join Reparacao on custosReparacoes.idReparacao = Reparacao.idReparacao
join Carro on Carro.idCarro = Reparacao.idCarro
where custoTotal = (
	select max(custoTotal) from 	custosReparacoes
	where custoTotal not in (
		select max(custoTotal) from custosReparacoes
	)
);
```

#### m. Quais	são	as	três	reparações	mais	caras	(ordenadas	por	ordem	decrescente de	preço)?


```sql
-- | idReparacao | custoTotal |

select *
from custosReparacoes
order by custoTotal desc
limit 3;
```




#### n. Quais	os	nomes	dos	clientes	responsáveis	por	reparações	de	carros	e respetivos	proprietários	(só	para	os	casos	em	que	não	são	coincidentes)?


```sql
-- | pagador | dono |

-- distincao por nome (atencao aos nomes duplicados. teria que se fazer a operação <> com ids e depois fazer join com tabela de clientes para obter os nomes)

select pagador_nome, dono_nome
from
(
	select idReparacao, nome as pagador_nome
	from Cliente
	join Reparacao
	on cliente.idCliente = Reparacao.idCliente
) as reparacoes_e_pagadores
join
(
	select idReparacao, nome as dono_nome
	from Reparacao
	join Carro
	on Reparacao.idCarro = Carro.idCarro
	join
	Cliente on Cliente.idCliente = Carro.idCliente
) as reparacaoes_e_donos
on reparacoes_e_pagadores.idReparacao = reparacaoes_e_donos.idReparacao
where pagador_nome <> dono_nome;
```

```sql
-- distincao por id

select pagador.nome as "pagador_nome",
proprietario.nome as "proprietario_nome"
from Cliente proprietario, Cliente pagador, Carro, Reparacao
where
-- obter dados do pagador
Reparacao.idCliente = pagador.idCliente
-- obter dados do proprietario
and Reparacao.idCarro = Carro.idCarro
and Carro.idCliente = proprietario.idCliente
and proprietario.idCliente <> pagador.idCliente;
```

#### o. Quais	as	localidades	onde	mora	alguém,	seja	ele	cliente	ou	funcionário?


#### p. Quais	as	localidades	onde	moram	clientes	e	funcionários?


#### q. Quais	as	peças	compatíveis	com	modelos	da	Volvo	cujo	preço	é	maior	do	que o	de	qualquer	peça	compatível	com	modelos	da	Renault?


#### r. Quais	as	peças	compatíveis	com	modelos	da	Volvo	cujo	preço	é	maior	do	que o	de	alguma	peça	compatível	com	modelos	da	Renault?


#### s. Quais	as	matriculas	dos	carros	que	foram	reparados	mais	do	que	uma	vez?


#### t. Quais	as	datas	de	início	e	de	fim	e	nome	do	proprietário	das	reparações feitas	por	carros	que	foram	reparados	mais	do	que	uma	vez?


#### u. Quais	as	reparações	que	envolveram	todas	as	especialidades?


#### v. Calcule	as	durações	de	cada	reparação,	contabilizando	até	à	data	atual	os	não entregues.


#### w. Substitua	Renault	por	Top,	Volvo	por	Down	e	os	restantes	por	NoWay.

## SQL Triggers

### Oficina

Triggers Exercício Oficina

#### a. Se não for especificado o cliente aquando a inserção de uma reparação, assumir que o cliente é o proprietário do carro.

**Trigger**

```sql
drop trigger if exists proprietario_paga_por_defeito;
create trigger proprietario_paga_por_defeito
  after insert on Reparacao
  for each row
  when (new.idCliente IS NULL)
  BEGIN
    UPDATE Reparacao
    SET idCliente =
    (
      select Carro.idCliente)
      where Carro=NEW.idCarro
    )
    where Reparacao.idReparacao = NEW.idReparacao;
  END;
```

**Teste**

```sql
delete from reparacao where idCarro isnull;

INSERT INTO Reparacao (dataInicio, dataFim, idCliente, idCarro)
	VALUES ('2010-09-17', '2010-09-20', NULL, 1);

select * from Reparacao;

```

#### b. . Simultaneamente: (1) impedir a atribuição de peças não compatíveis com o modelo do carro em reparação; e (2) impedir a atribuição de peças sem stock suficiente para satisfazer a quantidade pretendida na reparação.

**Trigger**

```sql
drop trigger if exists verifica_compatibilidade_e_stock;

create trigger verifica_compatibilidade_e_stock
  before insert on ReparacaoPeca
  for each row
  begin
  	-- Podíamos também fazer a validação de ambas as condições numa só query,
	-- mas aí não teríamos mensagens distintas para cada condição de erro. 
	-- Estaria correto de qq forma, pois é dito "simultaneamente" no enunciado
	--
	-- Primeira validação (stock suficiente)
    select case
    when
      exists (
          select *
          from Peca
          where idPeca = new.idPeca
          and new.quantidade > Peca.quantidade
      )
    then
      RAISE(ABORT, 'Não existe quantidade suficiente da peça em stock.')
    end;
	
	-- Segunda validação (compatibilidade das peças)
    select case
    when
      not exists (
        select *
        from
        Reparacao join Carro
        on Reparacao.idCarro = Carro.idCarro
        join Modelo
        on Carro.idModelo = Modelo.idModelo
        join PecaModelo
        on Carro.idModelo = PecaModelo.idModelo
        where PecaModelo.idPeca = new.idPeca
        and
        Reparacao.idReparacao = new.idReparacao
    )
    then
      RAISE(ABORT, 'A peca nao e compativel com o carro da reparacao.')
    end;
  end;
```
**Teste**

```sql
--stock insuficiente mas peça é compatível
insert into ReparacaoPeca(idReparacao,idPeca,quantidade)
    values(2, 1, 40000);

---stock suficiente mas peça nao e compatível
insert into ReparacaoPeca(idReparacao,idPeca,quantidade)
    values(1, 1, 1);

-- apagar entrada introduzida
-- com sucesso para novos testes
delete from ReparacaoPeca
    where idReparacao = 2
    and idPeca = 1
    and quantidade = 8;

---stock suficiente e peça é compatível
insert into ReparacaoPeca(idReparacao,idPeca,quantidade)
    values(2, 1, 8);
```

#### c. Atualizar automaticamente o stock de peças após inserção de registos na tabela ReparacaoPeca

**Trigger**

```sql
DROP TRIGGER IF EXISTS atualiza_stock_apos_reparacao;
CREATE TRIGGER atualiza_stock_apos_reparacao
  after insert on ReparacaoPeca
  FOR EACH ROW
  BEGIN
    update Peca
    set quantidade = (
        select (quantidade - new.quantidade)
        from Peca
        where idPeca = new.idPeca
    )
    where Peca.idPeca = new.idPeca;
  end;
```
**Teste**

```sql
-- apagar entrada introduzida
-- com sucesso para novos testes
delete from ReparacaoPeca
    where idReparacao = 2
    and idPeca = 1
    and quantidade = 8;


-- reestabelecer stock para novas execuçoes do insert
update Peca set quantidade = 100
  where idPeca = 1;

---stock suficiente e peça é compatível
insert into ReparacaoPeca(idReparacao,idPeca,quantidade)
    values(2, 1, 8);

select *
  from Peca
  where quantidade = 92 --(100 - 8, que é o que gastámos menos stock inicial de 100)
  and idPeca = 1;


select *
  from Peca;
```

#### d. Quando se inserem registos numa vista com os nomes de todos os modelos e respetivas marcas, estas inserções sejam propagadas para as tabelas que dão origem à vista.


**Trigger**

```sql
drop view if exists modelos_e_marcas;
create view modelos_e_marcas AS
  select
      Modelo.nome as nome_modelo,
      Marca.nome as nome_marca
  from
  Modelo join Marca on Modelo.idMarca = Marca.idMarca;

CREATE TRIGGER atualiza_modelos_e_marcas
  instead of insert on modelos_e_marcas
  for each row
  BEGIN
    insert or replace into Marca (idMarca, nome)
    values
    (
        (
            select idMarca
            from Marca
            where nome = new.nome_marca
        ),
        new.nome_marca
    );

    insert or replace into Modelo (idModelo, nome, idMarca)
    VALUES
    (
        (
            select idModelo
            from
            Modelo
            where nome = new.nome_modelo
        ),
        new.nome_modelo,
        (
                select idMarca
                from Marca
                where nome = new.nome_marca
        )
    );
END;
```

**Teste**

```sql
-- Remover inserçoes anteriores, para restaurar estado da BD

delete from Modelo where nome = 'Uno Turbo i.e.';
delete from Modelo where nome = '850R';
delete from Marca where nome = 'Fiat';

---modelo e marca nao existem
insert into modelos_e_marcas
(
    nome_modelo,
    nome_marca
)
values
('Uno Turbo i.e.', 'Fiat');

--- marca existe, modelo nao
insert into modelos_e_marcas
(
    nome_modelo,
    nome_marca)
values
('850 R', 'Volvo');

---modelo existe, marca nao (à partida impossivel pq tem
-- que haver uma marca sempre associada a um modelo! Só se o nome da marca
-- tiver mudado desde a sua inserção... código continua o mesmo mas nome
-- foi alterado na BD)
-- contudo, se usarmos update or replace,
-- a marca da V50 Momentum vai mudar para Mazda!
-- há uma forma de impedir isto? Será que faz sequer sentido impedir?
insert into modelos_e_marcas
(
  nome_modelo,
  nome_marca)
values
  --V50 Momentum é um Volvo na bd inicial.
  ('V50 Momentum', 'Mazda');
```

**Outra versão do Trigger**

{% include warning.html content="Solução inválida porque tem alguns erros clássicos, explicados abaixo." %}

```sql
drop view if exists modelos_e_marcas;
create view modelos_e_marcas
    as 
    select 
        Modelo.nome as nome_modelo,
        Marca.nome as nome_marca
    from 
        Modelo join Marca 
        on Modelo.idMarca = Marca.idMarca;
        
create trigger insertOnView
instead of insert on modelos_e_marcas
for each row
begin
    --- Erro 1 
    --- Inserçoes de nomes iguais nao sao detetadas / impedidas
    --- Solucao 1: 
    --- Mais adequada se pudermos mudar a base de dados: 
    --- Corrigir esquema relacional,
    --- Adicionando uma UNIQUE constraint em Marca.nome
    --- 
    --- Solucao 2:
    --- Mais interessante enquanto exercicio de triggers 
    --- So permitir a insercao se nao houver marca nenhuma 
    --- com aquele nome.
    insert into Marca(nome) values(new.nomeMarca);
    
    --- Erro 1 tambem existe aqui. Podem existir muitos modelos 
    --- com o mesmo nome e ate marcas diferentes.
    insert into Modelo(nome, idMarca) 
        --- Erro 2
        --- A primeira coluna e uma constante, que tem o nome do 
        --- novo modelo que se esta a inserir.
        --- A segunda coluna vai ter todos os id's das marcas
        --- Ao ser executado o insert, vamos inserir n linhas 
        --- na tabela Modelo, uma por cada marca,
        --- todas com o nome do modelo que se esta a inserir.
        --- O resultado sera como se passasse a haver n novos modelos, 
        --- um de cada marca, com o nome do novo modelo
        select new.nomeModelo, idMarca from Marca;
end;
```

**Outra versão do Trigger**

{% include warning.html content="Solução inválida porque tem insert dentro de select case. Erro explicado abaixo." %}

```sql
drop view if exists modelos_e_marcas;
create view modelos_e_marcas AS
  select
      Modelo.nome as nome_modelo,
      Marca.nome as nome_marca
  from
  Modelo join Marca on Modelo.idMarca = Marca.idMarca;

-- isto nao funciona devido ao uso de insert dentro de um case.
-- Select é operação de leitura, nao permite inserts.
-- https://stackoverflow.com/questions/20243739/insert-into-with-use-case-sqlite

CREATE TRIGGER atualiza_modelos_e_marcas
  instead of insert on modelos_e_marcas
  for each row
  BEGIN

  select case
    when
        not exists (
            select * from marca where nome = new.nome_marca
        )
    then
        insert into Marca(nome) VALUES (new.nome_marca);
    end;
  end;

  select case
    when
        not exists (
          select * from modelo where nome = new.nome_modelo
        )
        then
            insert into Modelo
                (nome,idMarca)
                VALUES
                (
                    new.nome_modelo,
                    (
                        select idMarca
                        from
                        Marca
                        where nome = new.nome_marca
                    )
                )
            )
        end;
    end;
  END;
```

## Clinica

### Triggers

#### a. Não permitir o utilizador marcar uma consulta caso o número de marcações para esse dia venha a ultrapassar a disponibilidade desse médico para esse dia.

**Trigger**

```sql
drop trigger if exists verifica_disponibilidade;
create trigger verifica_disponibilidade
  before insert on ConsultasMarcadas
  for each row
  begin
    select CASE
    when
    (
      (
        select count(*)
        from ConsultasMarcadas
        where codmedico = new.codMedico
        and data = new.data
      )
      >=
      (
        select HorarioConsultas.numdoentes
        from Disponibilidade join HorarioConsultas on Disponibilidade.idhorarioconsulta = HorarioConsultas.idhorarioconsulta
        where
        new.data = Disponibilidade.dia
      )
    )
    then
      raise(ABORT, 'Médico não tem disponibilidade para esse dia')
    end;
  end;
```

**Teste**

```sql
-- executar n vezes até deixar de permitir criar consultas
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (null, 02-05-2017, 9.30, 40, 'fisura na tibia esquerda', 'Amarelo', 1, 10);
```

#### b. Não permitir marcar uma consulta com a mesma hora de início de uma outra consulta no mesmo dia, mesmo médico.

**Trigger**

```sql
drop trigger if exists verifica_hora;
create trigger verifica_hora
  before insert on ConsultasMarcadas
  for each row
  begin
    select CASE
    when exists
    (
        select *
        from ConsultasMarcadas
        where
        codmedico = new.codMedico
        and
        data = new.data
        and
        horainicio = new.horaInicio
    )
    then
      raise(ABORT, 'Ja ha uma consulta marcada nessa hora a esse dia para esse medico')
    end;
  end;
```

**Teste**

```sql
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (null, 03-05-2017, 10, 40, 'Sindrome de Quervain no pulso esquerdo', 'Verde', 1, 14);
```

