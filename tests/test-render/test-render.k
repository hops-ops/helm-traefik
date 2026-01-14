import models.io.crossplane.apiextensions.v1 as apiextensions
import models.io.crossplane.pkg.v1 as pkg
import models.io.crossplane.pkg.v1beta1 as pkgv1beta1

import file

_oxr = lambda filename: str -> any {
    file.read(filename)
}

_ocds = lambda filename: str -> any {
    yaml.decode_all(file.read(filename))
}

test_render_minimal = lambda {
    _functionInput = {
        observed = {
            composite.resource = _oxr("observed-xr-minimal.yaml")
            resources = {}
        }
        desired = {
            composite.resource = _oxr("observed-xr-minimal.yaml")
            resources = {}
        }
        context = {}
    }
    got = apiextensions.CompositionTest {
        metadata.name = "render-minimal"
        spec = {
            compositionPath = "../../apis/traefiks/composition.yaml"
            xrdPath = "../../apis/traefiks/definition.yaml"
            timeoutSeconds = 10
            validate = True
            inputs = [_functionInput]
        }
    }
    assert got, "should create composition test for minimal"
}

test_render_standard = lambda {
    _functionInput = {
        observed = {
            composite.resource = _oxr("observed-xr-standard.yaml")
            resources = {}
        }
        desired = {
            composite.resource = _oxr("observed-xr-standard.yaml")
            resources = {}
        }
        context = {}
    }
    got = apiextensions.CompositionTest {
        metadata.name = "render-standard"
        spec = {
            compositionPath = "../../apis/traefiks/composition.yaml"
            xrdPath = "../../apis/traefiks/definition.yaml"
            timeoutSeconds = 10
            validate = True
            inputs = [_functionInput]
        }
    }
    assert got, "should create composition test for standard"
}
