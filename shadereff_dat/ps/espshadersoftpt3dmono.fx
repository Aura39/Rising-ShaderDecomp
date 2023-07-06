float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1.x = dot(r0.xyz, 0.298912);
	r1.xyz = -r0.xyz + r1.xxx;
	r1.w = 0;
	r0 = g_Rate.x * r1 + r0;
	r1.w = r0.w;
	r2.xy = float2(-0.0001, 0.5);
	r3 = r1.w * g_MatrialColor.w + r2.x;
	clip(r3);
	r2.x = 1 / i.texcoord1.w;
	r2.xz = r2.xx * i.texcoord1.xy;
	r2.z = r2.z * 0.5 + 0.5;
	r3.x = r2.x * r2.y + g_TargetUvParam.x;
	r3.z = -r2.z + g_TargetUvParam.y;
	r2.xy = r3.xz + float2(0.5, 1);
	r2 = tex2D(g_Sampler1, r2);
	r2.x = r2.x * g_CameraParam.y + g_CameraParam.x;
	r2.x = r2.x + -i.texcoord1.w;
	r2.x = r2.x * g_Rate.z;
	r1.xyz = g_MatrialColor.xyz;
	r1 = r1 * g_MatrialColor;
	r3 = r1.w * r2.x + -0.0001;
	r1.w = r2.x * r1.w;
	clip(r3);
	r0.w = g_MatrialColor.w;
	o = r0 * r1;

	return o;
}
