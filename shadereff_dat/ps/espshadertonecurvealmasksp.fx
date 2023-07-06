float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
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
	r0.xy = g_TargetUvParam.xy + i.texcoord1.xy;
	r0 = tex2D(g_Sampler1, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord1.w;
	r0.w = r0.x * g_Rate.z;
	r1 = tex2D(g_Sampler2, i.texcoord);
	r2 = tex2D(g_Sampler0, i.texcoord);
	r1.w = r1.w * r2.w;
	r1.xyz = g_Rate.yyy * r2.xyz + g_Rate.xxx;
	r1 = r1 * g_MatrialColor;
	r0.xyz = 1;
	o = r0 * r1;

	return o;
}
