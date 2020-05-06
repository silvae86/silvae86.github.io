---
layout: page
title: Databases (BDAD - MIEIC)
permalink: /teaching/2020/BDAD/
crumbtitle: BDAD
tags: teaching databases feup exercises sql
---

## "Tuned" scripts with more edge cases

[Oficina/Workshop]({% link _pages/teaching/2020/BDAD/scripts/oficina_with_ties.sql %})

- More than one most expensive repair to test whether or not your queries return more than one repair with the maximum cost.
- Second-most costly repair: 2 repairs also tied


## Some solutions to the SQL exercises

### Faculdade

#### 1. Quais	os	números	dos	alunos?

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
    cursos que cada aluno nao fez
    se tiver falhado pelo menos
    uma cadeira do curso, nao o fez
    (nao importa que cadeira tenha falhado!)
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

### Oficina

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
