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
	r0 = tex2D(g_Sampler2, i.texcoord);
	r0.x = g_Rate.y * r0.w + g_Rate.x;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.w = r0.x * r1.w;
	r0 = r1 * g_MatrialColor;
	r1.xy = g_TargetUvParam.xy + i.texcoord1.xy;
	r1 = tex2D(g_Sampler1, r1);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = r1.x + -i.texcoord1.w;
	r1.w = r1.x * g_Rate.z;
	r1.xyz = 1;
	o = r0 * r1;

	return o;
}
