# consultation_ad_powerShell

<div align="center">
  <img src="https://github.com/anth039/consultation_ad_powerShell/assets/88208959/bdc84dae-c08e-4edb-80ac-321438a39551" alt="Capture d'écran" />  
  <br>
  <p align="left">
    Application permettant d'afficher les informations des utilisateurs contenu dans un Active Directory (+Filtrage & +):
    <ul align="left">
      <li>Nom</li>
      <li>Prénom</li>
      <li>ID</li>
      <li>Email</li>
      <li>Statut</li>
      <li>Group</li>
      <li>Site</li>
    </ul>
  </p>  
  <p align="left">
    Application composée de deux partie : 
    <ul align="left">
      <li>RECUPERATION DES DONNEES</li>
      <ul>
        <li>Pré-requis :</li>
        <ul>
          <li>Service AD (Panneau de configuration => Programmes et fonctionnalités => Activer ou désactiver des fonctionnalités Windows)</li>
          <div align="center">
            <img src="https://github.com/anth039/consultation_ad_powerShell/assets/88208959/b000e3fe-f3d0-4203-b8be-d18a6b9c90b9" alt="Capture d'écran" />  
          </div>
          <li>Les outils d'administration Windows : https://www.microsoft.com/fr-FR/download/details.aspx?id=45520 </li>
        </ul>
      </ul>
      <br>
      <li>EXPLOITATION DES DONNEES</li>
      <ul>
        <li>Pré-requis :</li>
        <ul>
          <li>Remplissage des données suivantes </li>
          <h3>En début de code</h3>
          <div align="center">    
            <img src="https://github.com/anth039/consultation_ad_powerShell/assets/88208959/7794897c-a176-4f10-8de8-98effba8286b" alt="Capture d'écran" />  
          </div>  
          <h3>En fin de code</h3>
          <div align="center">    
             <img src="https://github.com/anth039/consultation_ad_powerShell/assets/88208959/802e17dc-7723-47a9-80a0-ab09b384539f" alt="Capture d'écran" />  
          </div> 
        </ul>
      </ul>
    </ul>
  </p>
  <p>
    Après exécution de AD_code_get_user, cela génère un fichier Json contenant les informations de votre AD.
  </p>
  <h3>
    Exécution de Consultation_AD (Dans le même répertoire ou se trouve le fichier de configuration)
  </h3>
  </p>
</div>
