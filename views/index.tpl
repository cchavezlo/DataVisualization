%rebase('app', title="Ciencia de Datos")

<h4>
  Dataset: <span class> Communities and Crime Unnormalized Data Set</span>
</h4>
<hr />
<div class="row center-align valign-wrapper">
  <div class="col">
    <h5>Información del dataset</h5>
  </div>
  <div class="col push-s3">
    Basado en:
    <div class="switch">
      <label>
        Lugares
        <input type="checkbox" id="attr_based" />
        <span class="lever"></span>
        Atributos
      </label>
    </div>
  </div>
  <div class="col push-s6">
    <a id="next" class="right btn">Siguiente</a>
  </div>
</div>
<div class="divider"></div>

<script>
  $("#next").click(function () {
    let attrs_list = [];
    $("#attrs_selected>li").each((idx, el) => {
      attrs_list.push(el.innerHTML);
    });
    if (attrs_list.length == 0) {
      alert("Seleccione al menos un atributo");
      return;
    }
    console.log(attrs_list);
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "/select_attrs";
    let value;
    for (const key in attrs_list) {
      value = attrs_list[key];
      if (value == "communityname") continue;
      const hiddenField = document.createElement("input");
      hiddenField.type = "hidden";
      hiddenField.name = "attrs[]";
      hiddenField.value = value;

      form.appendChild(hiddenField);
    }
    const hiddenField = document.createElement("input");
    hiddenField.type = "hidden";
    hiddenField.name = "attr_based";
    hiddenField.value = $("#attr_based").prop("checked");
    form.appendChild(hiddenField);

    document.body.appendChild(form);
    console.log(form);
    form.submit();
  });
</script>

%include('information', attr_data = attr_data, attr_detail = attr_detail)
