%rebase('app', title="Ciencia de Datos")

<h4>
    Exploración de datos:
</h4>
<hr />
<h5>Información por {{type_info}}:</h5>
<div class="divider"></div>

<table>
    <thead>
        <tr>
            <th></th>
            %for label in columns_detail:
            <th>{{label}}</th>
            %end
        </tr>
    </thead>

    <tbody>
        <tr>
            <th>Porcentaje de Valores nulos</th>
            %for label in columns_detail:
            <th>{{columns_detail[label]['perc']}}% - {{columns_detail[label]['len']}}</th>
            %end
        </tr>
        %for column_name, column_data in columns_data.items():
        <tr>
            <td>{{column_name}}</td>
            %for attr_name in columns_detail:
            <td>{{column_data[attr_name]}}</td>
            %end
        </tr>
        %end
    </tbody>

</table>