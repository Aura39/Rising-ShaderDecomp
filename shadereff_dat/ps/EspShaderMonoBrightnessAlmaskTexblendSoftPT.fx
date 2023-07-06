float4 g_BlendRate;
float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
sampler g_SamplerZmap;
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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = tex2D(g_Sampler2, i.texcoord);
	r2 = lerp(r1, r0, g_BlendRate.x);
	r0.x = max(r2.x, r2.y);
	r1.x = max(r0.x, r2.z);
	r0.x = r1.x * g_Rate.x;
	r0.y = dot(r2.xyz, 0.298912);
	r0.x = r0.x * r0.y;
	r0.x = r0.x * 0.39215687;
	o.xyz = r0.xxx * g_MatrialColor.xyz;
	r0 = tex2D(g_Sampler1, i.texcoord);
	r0.x = r0.w * r2.w;
	r0.y = 1 / i.texcoord1.w;
	r0.yz = r0.yy * i.texcoord1.xy;
	r0.z = r0.z * 0.5 + 0.5;
	r1.xw = float2(0.5, 1);
	r1.x = r0.y * r1.x + g_TargetUvParam.x;
	r1.z = -r0.z + g_TargetUvParam.y;
	r0.yz = r1.xz + 0.5;
	r2 = tex2D(g_SamplerZmap, r0.yzzw);
	r0.y = r2.x * g_CameraParam.y + g_CameraParam.x;
	r0.y = r0.y + -i.texcoord1.w;
	r0.y = r0.y * g_Rate.z;
	r0.x = r0.y * r0.x;
	r1 = r0.x * g_MatrialColor.w + r1.w;
	r0.x = r0.x * g_MatrialColor.w;
	o.w = r0.x;
	clip(r1);

	return o;
}
