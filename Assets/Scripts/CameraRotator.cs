using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotator : MonoBehaviour {
    void Update ()
    {
        float time = Time.time * .3f;
        transform.position = new Vector3(Mathf.Sin(time), Mathf.Cos(Time.time * .5f) * .1f, Mathf.Cos(time)) * 12f;
        transform.LookAt(new Vector3(0f, 0f, 0f));
    }
}
