float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);
sampler g_Zmap : register(s13);

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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.xy = r0.xy + g_Rate.zw;
	r0.z = 1 / i.texcoord1.w;
	r0.zw = r0.zz * i.texcoord1.xy;
	r0.zw = r0.zw * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy * g_Rate.xy + r0.zw;
	r1 = tex2D(g_Zmap, r0);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = -r1.x + abs(i.texcoord1.w);
	r0.xy = (-r1.xx >= 0) ? r0.xy : r0.zw;
	r0 = tex2D(g_Sampler1, r0);
	r1 = tex2D(g_Sampler2, i.texcoord);
	r0.w = r1.w;
	o = r0 * g_MatrialColor;

	return o;
}
