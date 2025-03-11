float4 g_AlphaRate : register(c186);
float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);
float4 g_TargetUvParam : register(c194);

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
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.xyz = g_Rate.yyy * r1.xyz + g_Rate.xxx;
	r2 = tex2D(g_Sampler2, i.texcoord);
	r1.w = g_AlphaRate.y * r2.w + g_AlphaRate.x;
	r1 = r1 * g_MatrialColor;
	r0.xyz = 1;
	o = r0 * r1;

	return o;
}
