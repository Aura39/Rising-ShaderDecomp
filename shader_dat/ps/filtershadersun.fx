float4 g_LightCol;
float4 g_LightPosVP;
float4 g_LightPow1;
float4 g_LightPow2;
sampler g_Sampler0;
float4 g_TargetUvParam;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float3 r0;
	float4 r1;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r1 = tex2D(g_Sampler0, r0);
	r0.z = r1.x + -g_LightCol.w;
	o.w = (-r0.z >= 0) ? 0 : 1;
	r0.x = r0.x + -g_LightPosVP.x;
	r1.y = -r0.y + g_LightPosVP.y;
	r1.x = abs(r0.x) * 1.7777;
	r1.x = -r1.x;
	r0.x = dot(r1.x, r1.x) + 0;
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.y = -r0.x + g_LightPow1.x;
	r0.x = -r0.x + g_LightPow2.x;
	r0.z = -g_LightPow1.y + g_LightPow1.x;
	r0.z = 1 / r0.z;
	r0.y = r0.z * r0.y;
	r0.y = r0.y * g_LightPow1.z;
	r0.z = -g_LightPow2.y + g_LightPow2.x;
	r0.z = 1 / r0.z;
	r0.x = r0.z * r0.x;
	r0.x = r0.x * g_LightPow2.z;
	r0.x = r0.x + r0.y;
	r0.xyz = r0.xxx * g_LightCol.xyz;
	r0.xyz = r0.xyz * g_LightPosVP.www;
	o.xyz = r0.xyz * r0.xyz;

	return o;
}
