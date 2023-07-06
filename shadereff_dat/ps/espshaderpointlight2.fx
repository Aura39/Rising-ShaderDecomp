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
	r0.xy = i.texcoord1.xy * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.xy + g_TargetUvParam.xy;
	r1 = tex2D(g_Sampler2, r0);
	r0 = tex2D(g_Sampler1, r0.zwzw);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord1.w;
	r0.y = 1 / g_Rate.x;
	r0.x = r0.y * abs(r0.x);
	r1.w = -r0.x + 1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r2 = r1 * r0;
	r0 = r0.w * r1.w + -0.001;
	clip(r0);
	r0.xyz = g_MatrialColor.www * g_MatrialColor.xyz;
	o.xyz = r0.xyz * r2.xyz;
	o.w = r2.w;

	return o;
}
