float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c43);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
samplerCUBE cubemap_sampler : register(s1);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 g_TargetUvParam : register(c194);
float4 lightpos : register(c62);
sampler normalmap_sampler : register(s2);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c45);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	r0 = float4(-0, -0, -0, -1) + i.color;
	r1.zw = float2(-0.5, 0.5);
	r0 = SoftPt_Rate.y * r0 + -r1.zzzw;
	r2.w = ambient_rate.w;
	r2 = r0.w * r2.w + -0.01;
	clip(r2);
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = i.texcoord.zw * tile.xy + tile.zw;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r2.x = r2.x * i.texcoord2.w;
	r1.xyz = r2.xxx * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.x = dot(r1.xyz, r1.xyz);
	r2.x = 1 / sqrt(r2.x);
	r1.xyz = r1.xyz * r2.xxx + -i.texcoord3.xyz;
	r2.xy = CubeParam.ww * r1.xy + i.texcoord3.xy;
	r1.xyz = r1.xyz * CubeParam.www;
	r1.xyz = Refract_Param.zzz * r1.xyz + i.texcoord3.xyz;
	r2.z = 1 / i.texcoord8.w;
	r2.zw = r2.zz * i.texcoord8.xy;
	r2.zw = r2.zw * float2(-0.5, 0.5) + 0.5;
	r2.zw = r2.zw + g_TargetUvParam.xy;
	r2.xy = r2.xy * -Refract_Param.yy + r2.zw;
	r2 = tex2D(RefractMap_sampler, r2);
	r3.xyz = lerp(r2.xyz, r0.xyz, Refract_Param.xxx);
	r0.x = r0.w * ambient_rate.w;
	r0.w = r0.x * prefogcolor_enhance.w;
	r2.x = dot(r1.xyz, transpose(viewInverseMatrix)[0].xyz);
	r2.y = dot(r1.xyz, transpose(viewInverseMatrix)[1].xyz);
	r2.z = dot(r1.xyz, transpose(viewInverseMatrix)[2].xyz);
	r1.x = dot(lightpos.xyz, r1.xyz);
	r1.y = dot(i.texcoord4.xyz, r2.xyz);
	r1.y = r1.y + r1.y;
	r2.xyz = r2.xyz * -r1.yyy + i.texcoord4.xyz;
	r2.w = -r2.z;
	r2 = tex2D(cubemap_sampler, r2.xyww);
	r1.y = r2.w * CubeParam.y + CubeParam.x;
	r2.xyz = r1.yyy * r2.xyz;
	r4.xyz = r3.xyz * r2.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.y + r1.x;
	r1.x = r1.x * 0.5 + 1;
	r1.xyz = r1.xxx * r3.xyz;
	r3.xyz = r4.xyz * CubeParam.zzz + r1.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r4.xyz + r3.xyz;
	r1.w = -r1.w + -CubeParam.z;
	r1.xyz = r2.xyz * r1.www + r1.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r0.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	o = r0 * finalcolor_enhance;

	return o;
}
