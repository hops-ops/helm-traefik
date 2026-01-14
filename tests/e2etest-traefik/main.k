import models.io.crossplane.apiextensions.v1 as apiextensions

e2etest = apiextensions.E2ETest {
    metadata.name = "e2etest-traefik"
    spec = {
        compositionPath = "../../apis/traefiks/composition.yaml"
        xrdPath = "../../apis/traefiks/definition.yaml"
        timeoutSeconds = 300
        skipDelete = False
        claimPath = "claim.yaml"
    }
}
