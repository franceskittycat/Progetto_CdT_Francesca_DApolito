<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" />

<!-- variabili per accedere più facilmente ai nodi-->
<xsl:variable name="title" select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
<xsl:variable name="editionStmt" select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt"/>
<xsl:variable name="biblStruct" select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct" />
<xsl:variable name="encodingDesc" select="tei:TEI/tei:teiHeader/tei:encodingDesc" />
<xsl:variable name="profileDesc" select="tei:TEI/tei:teiHeader/tei:profileDesc" />
<xsl:variable name="text" select="tei:TEI/tei:text" />
<xsl:variable name="facsimile" select="tei:TEI/tei:facsimile" />

<!-- template del documento -->
<xsl:template match="/">
    <html lang="it">
        <head>
            <link rel="stylesheet" href="style.css" type="text/css"/>
            <meta charset="utf-8"/>
            <title><xsl:value-of select="$title"/></title>
        </head>
        <body>
            <h1>
                <xsl:value-of select="$title"/>
            </h1>
            <h3>
                <p>
                    Codifica a cura di <xsl:value-of select="$editionStmt/tei:respStmt/tei:name"/>
                </p>
            </h3>
            <h4>
                <xsl:value-of select="$editionStmt/tei:edition"/>
            </h4> 
            <div class="navbar">
                    <a href="#info_biblio">Informazioni bibliografiche</a>
                    <a href="#codifica">Codifica e progetto</a>
                    <a href="#profilo_testo">Profilo del testo e regesto</a>
                    <a href="#trascrizione">Trascrizione</a>
                    <a href="#termini">Termini di interesse</a>
                    <a href="#entita_nominate">Entità nominate</a>
                    <a href="#facsimile">Facsimili</a>
            </div>
            <hr/>
            <xsl:apply-templates select="$biblStruct"/>
            <hr/>
            <xsl:apply-templates select="$encodingDesc"/>
            <hr/>
            <xsl:apply-templates select="$profileDesc"/>    
            <hr/>  
            <xsl:apply-templates select="$text"/>   
            <hr/>
            <xsl:call-template name="terms"/>
            <hr/>
            <xsl:call-template name="ent_nom"/>
            <hr/>
            <xsl:apply-templates select="$facsimile"/>
        </body>
    </html>
</xsl:template>

<!-- template per le informazioni bibliografiche -->
<xsl:template match="$biblStruct">
    <div class="section">
        <h3 id="info_biblio">Informazioni bibliografiche</h3>
            <ul>
                <li><b>Titolo: </b> <xsl:value-of select="tei:analytic/tei:title"/></li> 
                <li><b>Autore: </b> <xsl:value-of select="tei:analytic/tei:author" /></li>  
                <li><b>Pubblicato sulla rivista: </b> <xsl:value-of select="tei:monogr/tei:title"/></li>  
                <li><b>Volume: </b> <xsl:value-of select="tei:monogr/tei:biblScope[@unit='volume']"/></li>  
                <li><b>Fascicolo: </b> <xsl:value-of select="tei:monogr/tei:biblScope[@unit='issue']"/></li>  
                <li><b>Pagine: </b> <xsl:value-of select="tei:monogr/tei:biblScope[@unit='page']"/></li>  
                <li><b>Editore: </b> <xsl:value-of select="tei:monogr/tei:imprint/tei:publisher"/></li>  
                <li><b>Luogo di pubblicazione: </b> <xsl:value-of select="tei:monogr/tei:imprint/tei:pubPlace"/></li>  
                <li><b>Data di pubblicazione: </b> <xsl:value-of select="$profileDesc/tei:creation/tei:date"/></li> 
            </ul>
    </div>
</xsl:template>

<!-- template per la encodingDesc -->
<xsl:template match="$encodingDesc">
    <div class="section">
        <h3 id="codifica">Codifica e progetto</h3>
        <div class="section">
            <h4>Descrizione del progetto</h4>
            <xsl:value-of select="tei:projectDesc"/>
            <h5>COVerLeSS</h5>
            <p>COVerLeSS è un ambiente web integrato e open access, interamente dedicato alla ricezione contemporanea della letteratura del Verismo italiano. La forte impronta storico-sociale che ha caratterizzato le grandi opere e i testi fondativi di questo movimento (dalle novelle di Vita dei campi ai Malavoglia, dalle novelle Rusticane al Mastro-don Gesualdo, dal romanzo Giacinta di Capuana alle prime novelle di De Roberto), si è riflessa in un ricchissimo pullulare di recensioni, polemiche letterarie, saggi, interventi di tipo teorico, riflessioni in chiave militante.</p>
            <h5>"La Farfalla"</h5>
            <p>Fondata a Cagliari da Angelo Sommaruga, con cadenza quindicinale, «La Farfalla» vide la luce il 27 febbraio 1876. Si presentava al pubblico «semplice, pulita, senza fregi e senza fronzoli», quasi del tutto priva di quelle novità grafiche che caratterizzeranno le riviste successive. I maggiori collaboratori furono, oltre Giarelli, autore della maggior parte degli articoli, Ottone Bacaredda, Felice Cameroni, Paolo Valera, Ferdinando Fontana, Cesario Testa, Domenico Milelli, Remigio Zena. Nel 1877 Sommaruga ritornò a Milano, portando con sé la rivista. Il primo numero milanese del 30 settembre uscì con una nuova testata che preannunciava lo stile liberty: un disegno di Tranquillo Cremona che raffigurava una graziosa fanciulla incastonato tra le prime due lettere del titolo.</p>
        </div>
        <div class="section">
            <h4>Dichiarazioni Editoriali</h4>
            <ul>
            <xsl:for-each select="tei:editorialDecl/*">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
            </ul>
        </div>
    </div>
</xsl:template>

<!-- template per la profileDesc -->
<xsl:template match="$profileDesc">
    <div class="section">
        <h3 id="profilo_testo">Profilo del testo e regesto</h3>
        <div class="section">
            <h4>Profilo del testo</h4>
            <ul>
                <li><b>Tipo di testo: </b> <xsl:value-of select="tei:textClass/tei:keywords/tei:term[@type='text']"/></li>
                <li><b>Temi: </b> 
                    <xsl:for-each select="tei:textClass/tei:keywords/tei:term[@type='themes']">
                        <xsl:apply-templates select="."/>
                        <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each></li>
                <li><b>Lingue usate: </b> 
                    <xsl:for-each select="tei:langUsage/*">
                        <xsl:apply-templates select="."/>
                        <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each></li>
            </ul>
        </div>
        <div class="section">
            <h4 id="regesto">Regesto</h4>
            <p><xsl:value-of select="tei:abstract"/></p>
        </div>
    </div>
</xsl:template>


<!-- template per il testo -->
<xsl:template match="$text">
    <div class="section">
        <h2 id="trascrizione">Trascrizione</h2>
        <xsl:apply-templates/>
    </div>
</xsl:template>

<!-- template per le div -->
<xsl:template match="tei:div[@type='section' or @type='intestazione' or @type='closer']">
    <div class="{@type}">
        <h4>
            <xsl:choose>
                <xsl:when test="@type='section'">Sezione <xsl:value-of select="@n"/></xsl:when>
                <xsl:when test="@type='intestazione'">Intestazione</xsl:when>
                <xsl:when test="@type='closer'">Firma dell'autore</xsl:when>
            </xsl:choose>
        </h4>
        <xsl:apply-templates/>
    </div>
</xsl:template>

<!-- template per i paragrafi -->
<xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
</xsl:template>

<!-- template per i metamarks -->
<xsl:template match="tei:metamark">
        <div class="metamark">
            <h5>Divisore di sezione: <i><xsl:value-of select="tei:figure/tei:figDesc"/></i></h5>
        </div>
</xsl:template>

<!-- template per le interruzioni di pagina -->
<xsl:template match="tei:pb">
    <div class="page-break">
        <h5>Interruzione di pagina: <xsl:value-of select="@xml:id"/></h5>
    </div>
</xsl:template>

<!-- template per le interruzioni di colonna -->
<xsl:template match="tei:cb">
    <div class="column-break">
        <h5>Interruzione di colonna: <xsl:value-of select="@xml:id"/></h5>
    </div>
</xsl:template>

<!-- template per le interruzioni di riga -->
<xsl:template match="tei:lb">
    <xsl:if test="@rend='-'">-</xsl:if> <!-- se la lb ha attributo @rend='-' inserisco un trattino e vado a capo per mantenere la sillabazione originale-->
    <br/>
</xsl:template>

<!-- template per le parole che sulla fonte originale sono in corsivo e/o grassetto -->
<xsl:template match="tei:hi | tei:foreign | tei:persName | tei:orgName | tei:name | tei:distinct | tei:head | tei:title">
    <xsl:choose>
        <xsl:when test="contains(@rend,'italic') and contains(@rend,'bold')">
                <b><i><xsl:apply-templates/></i></b>
        </xsl:when>
        <xsl:when test="contains(@rend,'italic')">
            <i><xsl:apply-templates/></i>
        </xsl:when>
        <xsl:when test="contains(@rend,'bold')">
            <b><xsl:apply-templates/></b>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- template per i termini di interesse -->
<xsl:template name="terms">
    <div class="section">
        <h3 id="termini">Termini di interesse</h3>
        <ul>
            <xsl:for-each-group select="$text//tei:term" group-by="normalize-space()">  <!-- raggruppo i nodi di interesse -->
                <li><xsl:value-of select="current-grouping-key()"/></li> <!-- stampo il valore delle chiavi del gruppo per evitare ripetizioni-->
            </xsl:for-each-group>
        </ul>
    </div>
</xsl:template>

<!-- template per le entità nominate (anche qui sono state utilizzate le funzioni usate nel template dei term)-->
<xsl:template name="ent_nom">
    <div class="section">
        <h3 id="entita_nominate">Entità nominate</h3>
        <div class="section">
            <h4>Persone</h4>
            <ul>
                <xsl:for-each-group select="$text//tei:persName" group-by="normalize-space()">
                    <li><xsl:value-of select="current-grouping-key()"/></li> 
                </xsl:for-each-group>
            </ul>
        </div>
        <div class="section">
            <h4>Luoghi</h4>
            <ul>
                <xsl:for-each-group select="$text//tei:placeName" group-by="normalize-space()"> 
                    <li><xsl:value-of select="current-grouping-key()"/></li>
                </xsl:for-each-group>
            </ul>
        </div>
        <div class="section">
            <h4>Opere</h4>
            <ul>
                <xsl:for-each-group select="$text//tei:title" group-by="normalize-space()"> 
                    <li><xsl:value-of select="current-grouping-key()"/></li>
                </xsl:for-each-group>
            </ul>
        </div>
        <div class="section">
            <h4>Organizzazioni</h4>
            <ul>
                <xsl:for-each-group select="$text//tei:orgName" group-by="normalize-space()"> 
                    <li><xsl:value-of select="current-grouping-key()"/></li>
                </xsl:for-each-group>
            </ul>
        </div>
    </div>
</xsl:template>


<!-- template per i facsimili -->
<xsl:template match="$facsimile">
    <div class="section">
        <h4 id="facsimile">Facsimili</h4>
         <div class="section flex-container">
            <xsl:for-each select="tei:surface">
                <div class="flex-item">
                    <h5>
                        Facsimile <xsl:value-of select="@xml:id" />
                    </h5>
                    <img src="{tei:graphic/@url}" width="30%" style="padding: 20px" alt="Facsimile {@xml:id}"/>
                </div>
            </xsl:for-each>
        </div>
    </div>
</xsl:template>

</xsl:stylesheet>