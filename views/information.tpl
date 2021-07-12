<style>
  .dataset_attrs > li {
    list-style-type: disc !important;
    margin-left: 20px;
  }
</style>

<div class="row">
  <div class="col s9">
    <h5>Escoja atributos a analizar</h5>
    <ul class="collapsible">
      %for attr_type, attrs_data in attr_data.items():
      <li>
        <div class="collapsible-header">
          <h6>
            <b>{{ attr_type }} - {{ len(attrs_data) }} características</b>
          </h6>
        </div>
        <div class="collapsible-body">
          <ul class="dataset_attrs">
            %for attr_name, attrs_desc in attrs_data.items():
            <li>
              <b class="selectable">{{ attr_name }}</b
              >: <span class="desc"> {{ attrs_desc }} </span>
              %if attr_detail.get(attr_name) > 0:
              <span style="color: red">
                - Datos nulos: {{ attr_detail.get(attr_name) }}%</span
              >
              %else:
              <span style="color: green"> - No hay Datos nulos</span>
              %end
            </li>
            %end
          </ul>
        </div>
      </li>
      %end
    </ul>
  </div>
  <div class="col s3">
    <div class="sticky">
      <h5>Atributos escogidos</h5>

      <ul class="collection" id="attrs_selected"></ul>
    </div>
  </div>
</div>
<script>
  String.prototype.splice = function (idx, rem, str) {
    return this.slice(0, idx) + str + this.slice(idx + Math.abs(rem));
  };

  $(".dataset_attrs>li>span.desc").each((idx, element) => {
    let text = element.textContent;
    var regExp = /\(([^)]*)\)[^(]*$/;
    var matches = regExp.exec(text);

    //matches[1] contains the value between the parentheses
    let text_length = matches[1].length;
    let tag_color = "<span style='color: blue;'> ";
    let res = matches.input.splice(matches.index, 0, tag_color);
    res = res.splice(
      matches.index + tag_color.length + text_length + 2,
      0,
      "</span>"
    );
    element.innerHTML = res;
    // console.log(res);
  });

  $(".selectable").on("click", function (e) {
    let selected = e.target;
    let attr_list = $("#attrs_selected");
    // console.log(selected.classList);
    let is_selected = selected.classList.contains("selected");
    // let is_selected = false;
    if (is_selected) {
      selected.classList.remove("selected");
      $("#" + this.innerHTML).remove();
    } else {
      attr_list.append(
        `<li class="collection-item" id="${this.innerHTML}">${this.innerHTML}</li>`
      );
      selected.classList.add("selected");
    }
  });
</script>

<!-- <li>
        <div class="collapsible-header">
            <h6> <b>No predecibles </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">

            </ul>
        </div>
    </li>
    <li>
        <div class="collapsible-header">
            <h6> <b>Predecibles </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">
            </ul>
        </div>
    </li>
    <li>
        <div class="collapsible-header">
            <h6> <b> Metas potenciales a predecir </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">

                <ul>
        </div>
    </li>
</ul>

<ul class="collapsible">
    <li>
        <div class="collapsible-header">
            <h6> <b>No predecibles </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">
                <li>communityname: Community name - not predictive - for information only (string)</li>
                <li>state: US state (by 2 letter postal abbreviation)(nominal)</li>
                <li>countyCode: numeric code for county - not predictive, and many missing values (numeric)</li>
                <li>communityCode: numeric code for community - not predictive and many missing values (numeric)</li>
                <li>fold: fold number for non-random 10 fold cross validation, potentially useful for debugging, paired
                    tests - not
                    predictive (numeric - integer)</li>
            </ul>
        </div>
    </li>
    <li>
        <div class="collapsible-header">
            <h6> <b>Predecibles </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">
                <li>population: population for community: (numeric - expected to be integer)</li>
                <li>householdsize: mean people per household (numeric - decimal)</li>
                <li>racepctblack: percentage of population that is african american (numeric - decimal)</li>
                <li>racePctWhite: percentage of population that is caucasian (numeric - decimal)</li>
                <li>racePctAsian: percentage of population that is of asian heritage (numeric - decimal)</li>
                <li>racePctHisp: percentage of population that is of hispanic heritage (numeric - decimal)</li>
                <li>agePct12t21: percentage of population that is 12-21 in age (numeric - decimal)</li>
                <li>agePct12t29: percentage of population that is 12-29 in age (numeric - decimal)</li>
                <li>agePct16t24: percentage of population that is 16-24 in age (numeric - decimal)</li>
                <li>agePct65up: percentage of population that is 65 and over in age (numeric - decimal)</li>
                <li>numbUrban: number of people living in areas classified as urban (numeric - expected to be integer)
                </li>
                <li>pctUrban: percentage of people living in areas classified as urban (numeric - decimal)</li>
                <li>medIncome: median household income (numeric - may be integer)</li>
                <li>pctWWage: percentage of households with wage or salary income in 1989 (numeric - decimal)</li>
                <li>pctWFarmSelf: percentage of households with farm or self employment income in 1989 (numeric -
                    decimal)</li>
                <li>pctWInvInc: percentage of households with investment / rent income in 1989 (numeric - decimal)</li>
                <li>pctWSocSec: percentage of households with social security income in 1989 (numeric - decimal)</li>
                <li>pctWPubAsst: percentage of households with public assistance income in 1989 (numeric - decimal)</li>
                <li>pctWRetire: percentage of households with retirement income in 1989 (numeric - decimal)</li>
                <li>medFamInc: median family income (differs from household income for non-family households) (numeric -
                    may be
                    integer)
                </li>
                <li>perCapInc: per capita income (numeric - decimal)</li>
                <li>whitePerCap: per capita income for caucasians (numeric - decimal)</li>
                <li>blackPerCap: per capita income for african americans (numeric - decimal)</li>
                <li>indianPerCap: per capita income for native americans (numeric - decimal)</li>
                <li>AsianPerCap: per capita income for people with asian heritage (numeric - decimal)</li>
                <li>OtherPerCap: per capita income for people with 'other' heritage (numeric - decimal)</li>
                <li>HispPerCap: per capita income for people with hispanic heritage (numeric - decimal)</li>
                <li>NumUnderPov: number of people under the poverty level (numeric - expected to be integer)</li>
                <li>PctPopUnderPov: percentage of people under the poverty level (numeric - decimal)</li>
                <li>PctLess9thGrade: percentage of people 25 and over with less than a 9th grade education (numeric -
                    decimal)</li>
                <li>PctNotHSGrad: percentage of people 25 and over that are not high school graduates (numeric -
                    decimal)</li>
                <li>PctBSorMore: percentage of people 25 and over with a bachelors degree or higher education (numeric -
                    decimal)
                </li>
                <li>PctUnemployed: percentage of people 16 and over, in the labor force, and unemployed (numeric -
                    decimal)</li>
                <li>PctEmploy: percentage of people 16 and over who are employed (numeric - decimal)</li>
                <li>PctEmplManu: percentage of people 16 and over who are employed in manufacturing (numeric - decimal)
                </li>
                <li>PctEmplProfServ: percentage of people 16 and over who are employed in professional services (numeric
                    - decimal)
                </li>
                <li>PctOccupManu: percentage of people 16 and over who are employed in manufacturing (numeric - decimal)
                    #### No
                    longer
                    sure of difference from PctEmplManu - may include unemployed manufacturing workers ####</li>
                <li>PctOccupMgmtProf: percentage of people 16 and over who are employed in management or professional
                    occupations
                    (numeric - decimal)</li>
                <li>MalePctDivorce: percentage of males who are divorced (numeric - decimal)</li>
                <li>MalePctNevMarr: percentage of males who have never married (numeric - decimal)</li>
                <li>FemalePctDiv: percentage of females who are divorced (numeric - decimal)</li>
                <li>TotalPctDiv: percentage of population who are divorced (numeric - decimal)</li>
                <li>PersPerFam: mean number of people per family (numeric - decimal)</li>
                <li>PctFam2Par: percentage of families (with kids) that are headed by two parents (numeric - decimal)
                </li>
                <li>PctKids2Par: percentage of kids in family housing with two parents (numeric - decimal)</li>
                <li>PctYoungKids2Par: percent of kids 4 and under in two parent households (numeric - decimal)</li>
                <li>PctTeen2Par: percent of kids age 12-17 in two parent households (numeric - decimal)</li>
                <li>PctWorkMomYoungKids: percentage of moms of kids 6 and under in labor force (numeric - decimal)</li>
                <li>PctWorkMom: percentage of moms of kids under 18 in labor force (numeric - decimal)</li>
                <li>NumKidsBornNeverMar: number of kids born to never married (numeric - expected to be integer)</li>
                <li>PctKidsBornNeverMar: percentage of kids born to never married (numeric - decimal)</li>
                <li>NumImmig: total number of people known to be foreign born (numeric - expected to be integer)</li>
                <li>PctImmigRecent: percentage of _immigrants_ who immigated within last 3 years (numeric - decimal)
                </li>
                <li>PctImmigRec5: percentage of _immigrants_ who immigated within last 5 years (numeric - decimal)</li>
                <li>PctImmigRec8: percentage of _immigrants_ who immigated within last 8 years (numeric - decimal)</li>
                <li>PctImmigRec10: percentage of _immigrants_ who immigated within last 10 years (numeric - decimal)
                </li>
                <li>PctRecentImmig: percent of _population_ who have immigrated within the last 3 years (numeric -
                    decimal)</li>
                <li>PctRecImmig5: percent of _population_ who have immigrated within the last 5 years (numeric -
                    decimal)</li>
                <li>PctRecImmig8: percent of _population_ who have immigrated within the last 8 years (numeric -
                    decimal)</li>
                <li>PctRecImmig10: percent of _population_ who have immigrated within the last 10 years (numeric -
                    decimal)</li>
                <li>PctSpeakEnglOnly: percent of people who speak only English (numeric - decimal)</li>
                <li>PctNotSpeakEnglWell: percent of people who do not speak English well (numeric - decimal)</li>
                <li>PctLargHouseFam: percent of family households that are large (6 or more) (numeric - decimal)</li>
                <li>PctLargHouseOccup: percent of all occupied households that are large (6 or more people) (numeric -
                    decimal)</li>
                <li>PersPerOccupHous: mean persons per household (numeric - decimal)</li>
                <li>PersPerOwnOccHous: mean persons per owner occupied household (numeric - decimal)</li>
                <li>PersPerRentOccHous: mean persons per rental household (numeric - decimal)</li>
                <li>PctPersOwnOccup: percent of people in owner occupied households (numeric - decimal)</li>
                <li>PctPersDenseHous: percent of persons in dense housing (more than 1 person per room) (numeric -
                    decimal)</li>
                <li>PctHousLess3BR: percent of housing units with less than 3 bedrooms (numeric - decimal)</li>
                <li>MedNumBR: median number of bedrooms (numeric - decimal)</li>
                <li>HousVacant: number of vacant households (numeric - expected to be integer)</li>
                <li>PctHousOccup: percent of housing occupied (numeric - decimal)</li>
                <li>PctHousOwnOcc: percent of households owner occupied (numeric - decimal)</li>
                <li>PctVacantBoarded: percent of vacant housing that is boarded up (numeric - decimal)</li>
                <li>PctVacMore6Mos: percent of vacant housing that has been vacant more than 6 months (numeric -
                    decimal)</li>
                <li>MedYrHousBuilt: median year housing units built (numeric - may be integer)</li>
                <li>PctHousNoPhone: percent of occupied housing units without phone (in 1990, this was rare!) (numeric -
                    decimal)
                </li>
                <li>PctWOFullPlumb: percent of housing without complete plumbing facilities (numeric - decimal)</li>
                <li>OwnOccLowQuart: owner occupied housing - lower quartile value (numeric - decimal)</li>
                <li>OwnOccMedVal: owner occupied housing - median value (numeric - decimal)</li>
                <li>OwnOccHiQuart: owner occupied housing - upper quartile value (numeric - decimal)</li>
                <li>OwnOccQrange: owner occupied housing - difference between upper quartile and lower quartile values
                    (numeric -
                    decimal)</li>
                <li>RentLowQ: rental housing - lower quartile rent (numeric - decimal)</li>
                <li>RentMedian: rental housing - median rent (Census variable H32B from file STF1A) (numeric - decimal)
                </li>
                <li>RentHighQ: rental housing - upper quartile rent (numeric - decimal)</li>
                <li>RentQrange: rental housing - difference between upper quartile and lower quartile rent (numeric -
                    decimal)</li>
                <li>MedRent: median gross rent (Census variable H43A from file STF3A - includes utilities) (numeric -
                    decimal)</li>
                <li>MedRentPctHousInc: median gross rent as a percentage of household income (numeric - decimal)</li>
                <li>MedOwnCostPctInc: median owners cost as a percentage of household income - for owners with a
                    mortgage (numeric -
                    decimal)</li>
                <li>MedOwnCostPctIncNoMtg: median owners cost as a percentage of household income - for owners without a
                    mortgage
                    (numeric - decimal)</li>
                <li>NumInShelters: number of people in homeless shelters (numeric - expected to be integer)</li>
                <li>NumStreet: number of homeless people counted in the street (numeric - expected to be integer)</li>
                <li>PctForeignBorn: percent of people foreign born (numeric - decimal)</li>
                <li>PctBornSameState: percent of people born in the same state as currently living (numeric - decimal)
                </li>
                <li>PctSameHouse85: percent of people living in the same house as in 1985 (5 years before) (numeric -
                    decimal)</li>
                <li>PctSameCity85: percent of people living in the same city as in 1985 (5 years before) (numeric -
                    decimal)</li>
                <li>PctSameState85: percent of people living in the same state as in 1985 (5 years before) (numeric -
                    decimal)</li>
                <li>LemasSwornFT: number of sworn full time police officers (numeric - expected to be integer)</li>
                <li>LemasSwFTPerPop: sworn full time police officers per 100K population (numeric - decimal)</li>
                <li>LemasSwFTFieldOps: number of sworn full time police officers in field operations (on the street as
                    opposed to
                    administrative etc) (numeric - expected to be integer)</li>
                <li>LemasSwFTFieldPerPop: sworn full time police officers in field operations (on the street as opposed
                    to
                    administrative etc) per 100K population (numeric - decimal)</li>
                <li>LemasTotalReq: total requests for police (numeric - expected to be integer)</li>
                <li>LemasTotReqPerPop: total requests for police per 100K popuation (numeric - decimal)</li>
                <li>PolicReqPerOffic: total requests for police per police officer (numeric - decimal)</li>
                <li>PolicPerPop: police officers per 100K population (numeric - decimal)</li>
                <li>RacialMatchCommPol: a measure of the racial match between the community and the police force. High
                    values
                    indicate
                    proportions in community and police force are similar (numeric - decimal)</li>
                <li>PctPolicWhite: percent of police that are caucasian (numeric - decimal)</li>
                <li>PctPolicBlack: percent of police that are african american (numeric - decimal)</li>
                <li>PctPolicHisp: percent of police that are hispanic (numeric - decimal)</li>
                <li>PctPolicAsian: percent of police that are asian (numeric - decimal)</li>
                <li>PctPolicMinor: percent of police that are minority of any kind (numeric - decimal)</li>
                <li>OfficAssgnDrugUnits: number of officers assigned to special drug units (numeric - expected to be
                    integer)</li>
                <li>NumKindsDrugsSeiz: number of different kinds of drugs seized (numeric - expected to be integer)</li>
                <li>PolicAveOTWorked: police average overtime worked (numeric - decimal)</li>
                <li>LandArea: land area in square miles (numeric - decimal)</li>
                <li>PopDens: population density in persons per square mile (numeric - decimal)</li>
                <li>PctUsePubTrans: percent of people using public transit for commuting (numeric - decimal)</li>
                <li>PolicCars: number of police cars (numeric - expected to be integer)</li>
                <li>PolicOperBudg: police operating budget (numeric - may be integer)</li>
                <li>LemasPctPolicOnPatr: percent of sworn full time police officers on patrol (numeric - decimal)</li>
                <li>LemasGangUnitDeploy: gang unit deployed (numeric - integer - but really nominal - 0 means NO, 10
                    means YES, 5
                    means
                    Part Time)</li>
                <li>LemasPctOfficDrugUn: percent of officers assigned to drug units (numeric - decimal)</li>
                <li>PolicBudgPerPop: police operating budget per population (numeric - decimal)</li>

            </ul>
        </div>
    </li>
    <li>
        <div class="collapsible-header">
            <h6> <b> Metas potenciales a predecir </b></h6>
        </div>
        <div class="collapsible-body">
            <ul class="dataset_attrs">
                <li>murders: number of murders in 1995 (numeric - expected to be integer) potential GOAL attribute (to
                    be predicted)
                </li>
                <li>murdPerPop: number of murders per 100K population (numeric - decimal) potential GOAL attribute (to
                    be predicted)
                </li>
                <li>rapes: number of rapes in 1995 (numeric - expected to be integer) potential GOAL attribute (to be
                    predicted)
                </li>
                <li>rapesPerPop: number of rapes per 100K population (numeric - decimal) potential GOAL attribute (to be
                    predicted)
                </li>
                <li>robberies: number of robberies in 1995 (numeric - expected to be integer) potential GOAL attribute
                    (to be
                    predicted)
                </li>
                <li>robbbPerPop: number of robberies per 100K population (numeric - decimal) potential GOAL attribute
                    (to be
                    predicted)
                </li>
                <li>assaults: number of assaults in 1995 (numeric - expected to be integer) potential GOAL attribute (to
                    be
                    predicted)
                </li>
                <li>assaultPerPop: number of assaults per 100K population (numeric - decimal) potential GOAL attribute
                    (to be
                    predicted)
                </li>
                <li>burglaries: number of burglaries in 1995 (numeric - expected to be integer) potential GOAL attribute
                    (to be
                    predicted)</li>
                <li>burglPerPop: number of burglaries per 100K population (numeric - decimal) potential GOAL attribute
                    (to be
                    predicted)
                </li>
                <li>larcenies: number of larcenies in 1995 (numeric - expected to be integer) potential GOAL attribute
                    (to be
                    predicted)
                </li>
                <li>larcPerPop: number of larcenies per 100K population (numeric - decimal) potential GOAL attribute (to
                    be
                    predicted)
                </li>
                <li>autoTheft: number of auto thefts in 1995 (numeric - expected to be integer) potential GOAL attribute
                    (to be
                    predicted)</li>
                <li>autoTheftPerPop: number of auto thefts per 100K population (numeric - decimal) potential GOAL
                    attribute (to be
                    predicted)</li>
                <li>arsons: number of arsons in 1995 (numeric - expected to be integer) potential GOAL attribute (to be
                    predicted)
                </li>
                <li>arsonsPerPop: number of arsons per 100K population (numeric - decimal) potential GOAL attribute (to
                    be
                    predicted)
                </li>
                <li>ViolentCrimesPerPop: total number of violent crimes per 100K popuation (numeric - decimal) GOAL
                    attribute (to be
                    predicted)</li>
                <li>nonViolPerPop: total number of non-violent crimes per 100K popuation (numeric - decimal) potential
                    GOAL
                    attribute
                    (to be predicted)</li>

                <ul>
        </div>
    </li> 
</ul>-->
