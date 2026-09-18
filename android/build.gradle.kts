allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    fun fixNamespace(proj: Project) {
        val androidExt = proj.extensions.findByName("android")
        if (androidExt != null) {
            try {
                val getNamespace = androidExt.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(androidExt)
                if (currentNamespace == null) {
                    val setNamespace = androidExt.javaClass.getMethod("setNamespace", String::class.java)
                    val safeName = proj.name.replace("-", "_").replace(".", "_")
                    setNamespace.invoke(androidExt, "com.example.$safeName")
                }
            } catch (e: Exception) {
            }
        }
    }

    if (project.state.executed) {
        fixNamespace(project)
    } else {
        project.afterEvaluate {
            fixNamespace(this)
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
